FROM phusion/passenger-ruby21:0.9.14

# Set correct environment variables.
ENV HOME /root
ENV RAILS_ENV production

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

ADD . /home/app

WORKDIR /home/app
RUN /bin/bash -c -l 'gem install foreman'
RUN /bin/bash -c -l 'bundle install'

EXPOSE 80
# TODO: Figure out why Rails PID is not being cleaned up.
CMD /bin/bash -c -l 'rm -f /home/app/tmp/pids/server.pid && foreman run bundle exec rails server -p 80'

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
