FROM gradescope/auto-builds

# Install dependencies
RUN apt-get update
RUN apt-get -y install make gcc libssl-dev zlib1g-dev bundler sqlite3 libsqlite3-dev

# Create a non-priveleged user
RUN useradd autograder -md /home/autograder
USER autograder
WORKDIR /home/autograder

# Add rbenv to path
ENV PATH "/home/autograder/.rbenv/bin:/home/autograder/.rbenv/shims:$PATH"

# Install rbenv
RUN curl -sL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer > install.sh
RUN bash install.sh

# Install Ruby
RUN rbenv install 2.7.1
RUN rbenv global 2.7.1 && rbenv rehash

USER root

# Install necessary gems
RUN gem install minitest

WORKDIR /autograder

# Copy the runner script into the container
COPY run_autograder .
COPY run_tests .
COPY debug .
RUN chown autograder:autograder run_tests
