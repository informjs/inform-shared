CC=coffee
OUT=lib/notifier
IN=src/

all: lib
	${CC} -o ${OUT} -c ${IN}

lib:
	mkdir -p "${OUT}"

