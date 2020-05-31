all:
	cd setup && dune clean
	docker build . -t vcapra1/autograder-ocaml-example:latest
	docker push vcapra1/autograder-ocaml-example:latest
