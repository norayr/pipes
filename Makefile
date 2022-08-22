#VOC = /opt/voc/bin/voc
#BUILD=build
#mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
#mkfile_dir_path := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
#current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))
#
#all:
#			mkdir -p $(BUILD)
#			cd $(BUILD) && voc -s $(mkfile_dir_path)/src/pipes.Mod
.POSIX:

DEPS     = norayr/lists

GITHUB   = https://github.com/

ROOTDIR  = $$PWD

all: ${DEPS}
	@if [ ! -d build ]; then \
		mkdir build;           \
	fi

	@for i in $?; do                           \
		cp -r   ${ROOTDIR}/build                 \
		${ROOTDIR}/deps/$${i#*/}/build;          \
		make -C ${ROOTDIR}/deps/$${i#*/};        \
		cp -r   ${ROOTDIR}/deps/$${i#*/}/build/* \
		${ROOTDIR}/build/;                       \
	done

	@cd build; voc -s ${ROOTDIR}/../src/pipes.Mod

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

clean:
	rm -rf build

.PHONY: test
