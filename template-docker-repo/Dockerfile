FROM debian:jessie

################
#  System Deps #
################

RUN apt-get update && \
  apt-get install -y vim

# When done developing this dockerfile, make sure you clean up
# the apt-get junk for production
#RUN apt-get clean


################
#  App Deps    #
################

# TODO:
# Copy over your application stuff required to load up
# dependencies and then install those dependencies



################
#  App Source  #
################

# TODO:
# Copy over your apps sourcecode in this section



#############
#  Conclude #
#############

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod +x /sbin/entrypoint.sh
RUN echo ". /sbin/entrypoint.sh" > /root/.bash_history
WORKDIR /app

ENTRYPOINT ["/sbin/entrypoint.sh"]
