require 'spec_helper'


module FooBar

  describe FooBar do
    it 'has a version number' do
      expect(FooBar::VERSION).not_to be nil
    end

    it 'does something useful', current: true do
      result = FooBar.main
      expect(result).to eq("test")
    end
  end

end
