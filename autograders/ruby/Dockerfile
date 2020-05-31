FROM gradescope/auto-builds

# Install dependencies
RUN apt-get update
RUN apt-get -y install make gcc libssl-dev zlib1g-dev

# Create a non-priveleged user
RUN useradd autograder -md /home/autograder
USER autograder
WORKDIR /home/autograder

# Add rbenv to path
ENV PATH "$PATH:/home/autograder/.rbenv/bin:/home/autograder/.rbenv/shims"

# Install rbenv
RUN curl -sL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer > install.sh
RUN bash install.sh

# Install Ruby
RUN rbenv install 2.7.1
RUN rbenv global 2.7.1 && rbenv rehash

# Install necessary gems
RUN gem install minitest

USER root
WORKDIR /autograder

# Copy the runner script into the container
COPY run_autograder .
COPY run_tests .
RUN chown autograder:autograder run_tests
