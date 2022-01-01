# Pulling ubuntu image with a specific tag from the docker hub.
FROM ubuntu:18.04

# Updating the packages and installing cron and vim editor if you later want to edit your script from inside your container.
RUN apt-get update && \
  apt-get install cron -y

# Crontab file copied to cron.d directory.
COPY ./crontab /etc/cron.d/crontab
RUN chmod 0644 /etc/cron.d/crontab && \
  crontab /etc/cron.d/crontab

# Copy in script file.
COPY ./logdate.sh /logdate.sh
RUN chmod +x /logdate.sh

# Running commands for the startup of a container.
ENTRYPOINT ["cron", "-f"]
