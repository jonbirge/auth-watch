FROM jonbirge/octave:latest

# Deal with Ubuntu's tzdata package stupidity
ENV DEBIAN_FRONTEND=noninteractive

# Updating the packages and installing cron
RUN apt-get update && \
  apt-get install -y cron whois

# Create mount points
RUN mkdir /log /db /www

# Crontab file copied to cron.d directory
COPY ./crontab /etc/cron.d/crontab
RUN chmod 0644 /etc/cron.d/crontab && \
  crontab /etc/cron.d/crontab

# Copy in source files
COPY ./src /src
RUN chmod -R +x /src/*.sh

# Running commands for the startup of a container.
ENTRYPOINT ["cron", "-f"]
