FROM gradescope/auto-builds
WORKDIR /tmp

# Install dependencies
RUN apt-get update
RUN apt-get -y install make m4 gcc bubblewrap

# Install OPAM
RUN curl -sL https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh > install.sh
RUN echo '' | sh install.sh

# Install OCaml
RUN opam init --disable-sandboxing
RUN eval `opam env`
RUN opam switch create 4.10.0
RUN eval `opam env`

# Install necessary OPAM packages
RUN opam install -y ocamlfind ounit dune

# Create a non-priveleged user
RUN useradd autograder

WORKDIR /autograder

COPY run_autograder .
