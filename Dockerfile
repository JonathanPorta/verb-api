FROM fedora:20

RUN yum install wget make bzip2 --assumeyes

# Download and build chruby
RUN wget -O /tmp/chruby-0.3.8.tar.gz https://github.com/postmodern/chruby/archive/v0.3.8.tar.gz
RUN tar -xzf /tmp/chruby-0.3.8.tar.gz -C /tmp/
RUN /bin/make -C /tmp/chruby-0.3.8/ install
RUN echo 'source /usr/local/share/chruby/chruby.sh' >> $HOME/.bashrc

# Download and build ruby-install
RUN wget -O /tmp/ruby-install-0.4.3.tar.gz https://github.com/postmodern/ruby-install/archive/v0.4.3.tar.gz
RUN tar -xzf /tmp/ruby-install-0.4.3.tar.gz -C /tmp/
RUN /bin/make -C /tmp/ruby-install-0.4.3 install

# Download and build ruby
RUN /bin/bash -c -l 'ruby-install ruby 2.1'

# Download and install rubygems
RUN wget -O /tmp/rubygems-2.4.2.tgz http://production.cf.rubygems.org/rubygems/rubygems-2.4.2.tgz
RUN tar -xzf /tmp/rubygems-2.4.2.tgz -C /tmp/
RUN /bin/bash -c -l 'cd /tmp/rubygems-2.4.2 && ruby setup.rb'

# Install bundler
RUN /bin/bash -c -l 'gem install bundler --no-ri --no-rdoc'
RUN /bin/bash -c -l 'bundle config path "$HOME/bundler"'
