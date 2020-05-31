all:
	cd setup && dune clean
	docker build . -t vcapra1/autograder-ruby-example:latest
	docker push vcapra1/autograder-ruby-example:latest
