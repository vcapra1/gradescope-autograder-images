for d in $(ls */Dockerfile)
do
    dir=$(dirname $d)
    cd $dir
    docker build . --tag vcapra1/autograder-$dir:latest
done
