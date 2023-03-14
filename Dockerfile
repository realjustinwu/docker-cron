FROM ubuntu:latest
MAINTAINER justinwutop@gmail.com

# Add crontab file in the cron directory
ADD crontab /etc/cron.d/my-cron
ADD cmd.sh /var/cmd.sh

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/my-cron
RUN chmod 0644 /var/cmd.sh

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

#Install Cron
RUN apt-get update
RUN apt-get -y install cron rsync openssh-client

RUN mkdir -p /root/.ssh/; echo -e 'Host *\n StrictHostKeyChecking no' > /root/.ssh/config

# Run the command on container startup
CMD cron && tail -f /var/log/cron.log
