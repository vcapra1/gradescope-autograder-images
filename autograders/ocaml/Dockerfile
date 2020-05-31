FROM gradescope/auto-builds

# Install dependencies
RUN apt-get update
RUN apt-get -y install make m4 gcc bubblewrap

# Create a non-priveleged user
RUN useradd autograder -md /home/autograder
USER autograder
WORKDIR /home/autograder

# Create a personal bin directory for this user, and add it to the path
RUN mkdir bin
ENV PATH "$PATH:/home/autograder/bin"

# Install OPAM
RUN curl -sL https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh > install.sh
RUN echo '/home/autograder/bin' | sh install.sh

# Install OCaml
RUN opam init --disable-sandboxing
RUN eval `opam env`
RUN opam switch create 4.10.0
RUN eval `opam env`

# Install necessary OPAM packages
RUN opam install -y ocamlfind ounit dune

USER root
WORKDIR /autograder

# Copy the runner script into the container
COPY run_autograder .
COPY run_tests .
RUN chown autograder:autograder run_tests
