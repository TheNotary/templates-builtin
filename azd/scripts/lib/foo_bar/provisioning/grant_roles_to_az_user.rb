# frozen_string_literal: true

require "yaml"

# Grants the deploying user the Azure RBAC roles listed under
# deployer-role-assignments in azure.yaml.  Each entry specifies the role GUID
# and the env var that holds the target resource name, so nothing is hardcoded.
#
# Runs as part of the postprovision hook in azure.yaml.

module FooBar
  module Provisioning
    module GrantRolesToAzUser
      extend FooBar::Helpers

      def self.run
        rg = ENV.fetch("AZURE_RESOURCE_GROUP", nil)

        if blank?(rg)
          log "Skipping RBAC grants — missing AZURE_RESOURCE_GROUP env var."
          return
        end

        assignments = load_role_assignments
        if assignments.empty?
          log "No deployer-role-assignments defined in azure.yaml — skipping RBAC grants."
          return
        end

        user_oid = get_user_oid
        return if user_oid.nil?

        assignments.each do |role_name, config|
          role_id = config["role-id"]
          resource_env = config["resource-name-env"]
          resource_name = ENV.fetch(resource_env, nil)

          if blank?(resource_name)
            log "Skipping #{role_name} — env var #{resource_env} is not set."
            next
          end

          resource_scope = sh_capture(
            "az storage account show --name #{resource_name} --resource-group #{rg} --query id -o tsv"
          ).strip

          assign_role(role_name, role_id, user_oid, resource_scope, resource_name)
        end
      end

      def self.load_role_assignments
        azure_yaml_path = File.join(FooBar::Helpers::REPO_ROOT, "azure.yaml")
        config = YAML.safe_load_file(azure_yaml_path)
        config.fetch("deployer-role-assignments", {})
      end
      private_class_method :load_role_assignments

      def self.get_user_oid
        user_oid = sh_capture("az ad signed-in-user show --query id -o tsv").strip
        if blank?(user_oid)
          log "Could not determine signed-in user OID — skipping RBAC grants."
          return
        end

        user_oid
      end
      private_class_method :get_user_oid

      def self.assign_role(role_name, role_id, user_oid, resource_scope, resource_name)
        # Check if assignment already exists
        existing = sh_capture(
          "az role assignment list --assignee #{user_oid} --scope #{resource_scope} " \
          "--role #{role_id} --query \"[0].id\" -o tsv",
          allow_failure: true
        )

        unless blank?(existing)
          log "Deploying user already has role #{role_name} (#{role_id}) on #{resource_name}."
          return
        end

        log "Granting role #{role_name} (#{role_id}) to deploying user on #{resource_name}..."

        sh(
          "az role assignment create " \
          "--assignee-object-id #{user_oid} " \
          "--assignee-principal-type User " \
          "--role #{role_id} " \
          "--scope #{resource_scope} " \
          "-o none"
        )

        log "Role assignment created. Note: propagation may take up to 60s."
      end
      private_class_method :assign_role
    end
  end
end
