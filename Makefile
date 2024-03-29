.POSIX:

DEPS     = norayr/strutils

GITHUB   = https://github.com/

ROOTDIR  = $$PWD

all: ${DEPS}
	@if [ ! -d build ]; then \
		mkdir build;           \
	fi

	@cd build; voc -s ${ROOTDIR}/../src/pipes.Mod \
			${ROOTDIR}/../test/testPipes.Mod -M

${DEPS}:
	@for i in $@; do                              \
		if [ -d deps/$${i#*/} ]; then               \
			printf "Updating %s: " $${i#*/};          \
			git -C deps/$${i#*/} pull --ff-only       \
				${GITHUB}$$i > /dev/null 2>&1           \
				&& echo done                            \
				|| (echo failed && exit 1);             \
		else                                        \
			printf "Fetching %s: " $${i#*/};          \
			git clone ${GITHUB}$$i deps/$${i#*/}      \
				> /dev/null 2>&1                        \
				&& echo done                            \
				|| (echo failed && exit 1);             \
		fi                                          \
	done

test:
	@for i in $?; do                           \
		cp -r   ${ROOTDIR}/build                 \
		${ROOTDIR}/deps/$${i#*/}/build;          \
		make -C ${ROOTDIR}/deps/$${i#*/};        \
		cp -r   ${ROOTDIR}/deps/$${i#*/}/build/* \
		${ROOTDIR}/build/;                       \
	done



clean:
	rm -rf build

.PHONY: test
