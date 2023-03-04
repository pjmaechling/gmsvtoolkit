# -rm removes container on ext
# -it indicates inteactive + --tty so that users are at an interactive tty command line when the container starts
docker run --rm -i -t --mount type=bind,source="$(pwd)"/target,destination=/home/scecuser/target gmsvtoolkit:0304
