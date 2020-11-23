# Gradescope Autograder Docker Images

This repository contains base Docker images for setting up projects for the Gradescope Autograder in the [autograders](autograders) folder, and example project setups in the [examples](examples) folder.

## Project Setup Instructions

### Ruby

The project structure should be as follows (this example uses Ruby, there are minor differences with other languages which can be identified in the [examples](examples)):

```
project-root/
    setup/
        src/
        test/
            moduleA/
                moduleA.rb
            moduleB
                moduleB.rb
    Dockerfile
    Makefile
    tests.csv
```

The `setup` directory contains the actual project, and the other three files outside it are used for setup only (these will be discussed later).  Inside the `setup` directory there must be a `src` directory, which contains the student's code as well as other code required to make the project run; and a `test` directory which contains the testing files.

Inside the `test` directory, there can be multiple testing modules (for example, public, semipublic, and secret tests would all be separate modules).  Consider a project with a "public" testing module.  Then there would be a file **test/public/public.rb** which would look something like this:

```ruby
require "minitest/autorun"
require_relative "../../src/example.rb"

class PublicTests < Minitest::Test
    def test_init
        e = Example.new
        assert_equal "Hello, world!", e.hw
    end

    def test_rand
        e = Example.new
        assert_equal 5, e.random_digit
    end
end
```

Notice that the test imports the students' code which is two directories up, then into the `src` directory.  Minitest is already installed in the autograder setup.  If you need a different testing library (or need to install other packages), you'll need to modify the base images in the [autograders](autograders) folder (this should involve modifying the Dockerfile only).

Back outside the `setup` directory, the `Dockerfile` specifies how to set this project up.  It will look like this:

```dockerfile
FROM vcapra1/autograder-ruby:latest

# Get the test definitions
WORKDIR /autograder
COPY tests.csv .

# Get the base project files (don't include any files the students will be submitting)
WORKDIR /autograder/base

# You shouldn't need to modify anything above this line, except maybe the first one

COPY setup/test test
RUN mkdir -p src
```

As noted in the comment, you shouldn't need to modify the first part of this file (except the first line if you are changing the repository where the base autograder images are hosted).  Below that, you will COPY any files from the setup directory into the autograder image (e.g. setup/test -> test above), or create any files/directories necessary (e.g. src above).  **IMPORTANT**: don't copy in files that students should be implementing.  As a security measure, once files are copied into the autograder, they are write-protected.  So if you include a file that the students are going to submit, it will fail when it tries to copy their submission file into the testing environment.

The `Makefile` is just an easy way to update the Docker image.  This will build the docker image locally and then push it.  **WARNING**: this repository must be private.  If it is public, students will be able to see the contents of the tests by downloading the image.  Free Docker Hub only allows one private repository, so what I do is host all of the images under the same image with different tags.  So for project 1 in Fall 2020, the `Makefile` looked like this:

```makefile
all:
    docker build . -t vcapra1/cmsc330-autograders:f20-p1
    docker push vcapra1/cmsc330-autograders:f20-p1
```

Then, for project 2, you could use the same image but use the tag `f20-p2` instead.  You'll have to modify this `Makefile` to reference your own Docker image instead of mine.

Finally, `tests.csv` specifies the tests for the project.  It should be formatted as follows:

```csv
Name,Points,Type,Timeout
public:0:test_init,25,public,30
public:1:test_rand,25,public,30
secret:0:test_init,25,secret,30
secret:1:test_rand,25,secret,30
```

Note that the name of the first test is `public:0:test_init`, it is 25 points, it is *public* which means students can see the results on each submission, and it has a timeout of 30 seconds.  The name of the test is a bit bizarre, as it is intended to be similar to how OCaml names tests.  It is structured as `<module>:<index>:<name>` where `<module>` is the name of the test file, the indices start at 0, and the name is the name of the test function.  The Type can be either `public`, `secret`, or `required`.  A test of type `secret` will be hidden from students.  The student will receive a 0 on the entire assignment if they fail even one `required` test.

You should take care to ensure that the total timeouts of all tests does not exceed the timeout set in the settings page on Gradescope.  Otherwise, Gradescope could forcefully terminate the tests, resulting in a 0 rather than giving credit to those tests which did pass in time.
