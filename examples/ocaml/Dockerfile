FROM vcapra1/autograder-ocaml:latest

# Get the test definitions
WORKDIR /autograder
COPY tests.csv .

# Get the base project files (don't include any files the students will be submitting)
WORKDIR /autograder/base

COPY setup/dune-project dune-project
COPY setup/test test
COPY setup/src/example.mli src/example.mli
COPY setup/src/dune src/dune
