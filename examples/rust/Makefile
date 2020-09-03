all:
	cd setup && cargo clean
	docker build . -t vcapra1/autograder-rust-example:latest
	docker push vcapra1/autograder-rust-example:latest
