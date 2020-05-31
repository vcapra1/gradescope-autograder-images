FROM vcapra1/autograder-ruby:latest

# Get the test definitions
WORKDIR /autograder
COPY tests.csv .

# Get the base project files (don't include any files the students will be submitting)
WORKDIR /autograder/base

COPY setup/test test
RUN mkdir -p src
