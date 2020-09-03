FROM vcapra1/autograder-rust:latest

# Get the test definitions
WORKDIR /autograder
COPY tests.csv .

# Get the base project files (don't include any files the students will be submitting)
WORKDIR /autograder/base

COPY setup/Cargo.toml Cargo.toml
COPY setup/tests tests
RUN mkdir -p src
