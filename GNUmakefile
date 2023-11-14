VOC = /opt/voc/bin/voc
mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
mkfile_dir_path := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
ifndef BUILD
BUILD="build"
endif
build_dir_path := $(mkfile_dir_path)/$(BUILD)
current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))
BLD := $(mkfile_dir_path)/build
DPD  =  deps
ifndef DPS
DPS := $(mkfile_dir_path)/$(DPD)
endif
all: get_deps build_deps buildPipes

get_deps:
	mkdir -p $(DPS)
	if [ -d $(DPS)/strutils ]; then cd $(DPS)/strutils; git pull; cd -; else cd $(DPS); git clone https://github.com/norayr/strutils; cd -; fi

build_deps:
	mkdir -p $(BUILD)
	cd $(BUILD)
	make -f $(DPS)/strutils/GNUmakefile BUILD=$(BUILD)

buildPipes:
	cd $(BUILD) && $(VOC) -s $(mkfile_dir_path)/src/pipes.Mod

tests:
	cd $(BUILD) && $(VOC) $(mkfile_dir_path)/test/testPipes.Mod -m
	build/testPipes

clean:
	if [ -d "$(BUILD)" ]; then rm -rf $(BLD); fi
