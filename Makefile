CC=coffee
OUT=lib/inform
IN=src/

all: lib
	${CC} -o ${OUT} -c ${IN}

lib:
	mkdir -p "${OUT}"

