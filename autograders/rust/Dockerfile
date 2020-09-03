FROM gradescope/auto-builds

# Install dependencies
RUN apt-get update
RUN apt-get -y install curl gcc

# Create a non-priveleged user
RUN useradd autograder -md /home/autograder
USER autograder
WORKDIR /home/autograder

# Add cargo to path
ENV PATH "$PATH:/home/autograder/.cargo/bin"

# Install rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

USER root
WORKDIR /autograder

# Copy the runner script into the container
COPY run_autograder .
COPY run_tests .
COPY debug .
RUN chown autograder:autograder run_tests
