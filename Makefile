#Makefile Style t om-code
#versi on 0.1 
#Support GNU make 4.1 or higher
NAME := CoreExecute
CC := g++
CFLAGS := -c -Wall
LINKER_FLAGS = -w -lmingw32 -lSDL2main -lSDL2 -lSDL2_net
ifeq ($(OS),Windows_NT)
	LINKER_FLAGS = -w -lmingw32 -lSDL2main -lSDL2 -lSDL2_net
else
	LINKER_FLAGS = -w -lSDL2main -lSDL2 -lSDL2_net
endif
INCLUDE := -I.\lib\include
LIBDIR := -L.\lib\lib

SRC_DIR := src
OBJ_DIR := obj
OUT_DIR := bin
LIB_DIR := lib
SRC_FILES := $(wildcard $(SRC_DIR)/*.cpp)
OBJ_FILES := $(patsubst $(SRC_DIR)/%.cpp, $(OBJ_DIR)/%.o, $(SRC_FILES))


define templateCpp
#include<iostream>
using namespace std;
int main(int argc,char **argv)
{
	cout<<"\tHELLO WORLD!"<<endl;
	return 0;
}
endef
define menu_ui
                                        
         (\/)      tom-code             
         (..)    Makefile C++           
        c(")(")   pookstudio            
                                        
   _______________ Menu _______________ 
  |                                    |
  |   New Template  >>  make new       |
  |   Compile       >>  make compile   |
  |   Build         >>  make build     |
  |   Compile&build >>  make b         |
  |   Clean         >>  make clean     |
  |   Run           >>  make run       |
  |   Contact       >>  make contact   |
  |____________________________________|
                                        
    *** Changes OS clean Before Compile     
        Example >> make clean 
                                        
endef
define new_ui

    /^\_/^\      
    ( o.o )  Generate Projects
     > ^ <        Success
    /  |  \ 
    -Projects-
        -bin
            /*execute file*/
        -obj
            /*compile file*/
        -src
            /*source  file*/
        -lib
            /*libary  file*/
        Makefile

endef
define b_ui
                 _______________________
               _|Compile + Build Success|____
              |   ____                       |
    (\__/)    |  |  |_|    ___|\    100100   |
    (='.')    |  |</> |   |___  )   011010   |
    (_(")(")  |  |____|       |/    101101   |
              |______________________________|

endef
define compile_ui
                 _______________
               _|Compile Success|____________
              |   ____               _____   |
    (\ (\     |  |  |_|    ___|\    / OBJ \  |
    ( -.-)    |  |</> |   |___  )   |[] []|  |
    O_(")(")  |  |____|       |/     \___/   |
              |______________________________|

endef
define build_ui
                 _____________
               _|Build Success|______________
              |   _____                      |
    /^\_/^\   |  / OBJ \   ___|\    100100   |
    (>'.'<)   |  |[] []|  |___  )   011010   |
     (""")    |   \___/       |/    101101   |
              |______________________________|

endef
define clean_ui
                 _____________
               _|Clean Success|______________
              |                       _____  |
    (\___/)   |   ?/!&(0    ___|\    |     | |
    (='.'=)   |   DELETE   |___  )   |Empty| |
    (")_(")   |   #\@&}X       |/    |_____| |
              |______________________________|

endef
define contact_ui

  _/\ /\_______________+.+____________
  |('v')                             |
  |         pookstudio@gmail.com     |
  |__________________________________|

endef
define run_uii
     _ _  __    _  _ _  _ 
    - /)/)- __- --_-  -_ --
     (>.<) --_  _- --_-_  ---
    -_\__\-   _--_ ---_- --

endef
define run_ui
     _ _  __    _  _ _  _ 
    - /)/)-   - -- -  -  --
endef
define compile_ui_err

     ,,,,,      -Compile Fail-
     (o o)      No source file
      (_)         check src

endef
define build_ui_err

   (|_____|)      -Build Fail-
     (o o)      No objects file
      (_)      check compile obj

endef
define b_ui_err

    ///////      -Compile + Build Fail-
     (o o)       No source or obj file 
      (_)        check your source file

endef
define run_ui_err

  (_)_____(_)      -Run Fail-
     (o o)      No execute file
      (_)        compile&build
endef
define new_ui_err

     (\_/)                          o_o_
    =(^.^)=   Your projects already  ( u ) 
      ) (
     

endef


.PHONY: clean all new compile compile_process build build_process 

all:
	$(info $(menu_ui))
	@:


new: init
ifeq ("$(wildcard $(SRC_DIR)/*)","")
	$(file > $(SRC_DIR)/main.cpp, $(templateCpp))
	$(info $(new_ui))
else
	$(info $(new_ui_err))
endif
	@:


compile: compile_process
ifneq ("$(wildcard $(SRC_DIR)/*)","")
	$(info $(compile_ui))
else
	$(info $(compile_ui_err))
endif
	@:
compile_process: init $(OBJ_FILES)
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	@$(CC) $(CFLAGS) $(INCLUDE) -o $@ $<


build: build_build build_process
	$(info $(build_ui))
	@:
build_build:
ifeq ("$(wildcard $(OBJ_DIR)/*o)","")
	$(info $(build_ui_err))
endif
build_process: $(OBJ_DIR)/*o
	@$(CC) -o $(OUT_DIR)/$(NAME) $^ $(LIBDIR) $(LINKER_FLAGS)

b: init b_before b_process
b_before:
ifneq ("$(wildcard $(SRC_DIR)/*)","")
	$(info $(b_ui))
else
	$(info $(b_ui_err))
endif
b_process: $(OBJ_FILES)
	@$(CC) -o $(OUT_DIR)/$(NAME) $^ $(LIBDIR) $(LINKER_FLAGS)


run: run_process
	$(info )
run_process:
ifneq ("$(wildcard $(OUT_DIR)/$(NAME))",-f)
	$(info $(run_ui))
	$(info $()   - (>.<) [Run] ./$(OUT_DIR)/$(NAME))
	$(info $()    -_\__\-   _--_ ---_- --)
	$(info )
	@$(OUT_DIR)/$(NAME)
else
	$(info $(run_ui_err))
endif
	@:


clean: clean_process
	$(info $(clean_ui))
clean_process:
	@-rm -rf $(OBJ_DIR)/*o
	@-rm -rf $(OUT_DIR)/*


init: $(SRC_DIR) $(LIB_DIR) $(OBJ_DIR) $(OUT_DIR)
$(OBJ_DIR):
	@-mkdir $@ $<
$(OUT_DIR):
	@-mkdir $@ $<
$(SRC_DIR):
	@-mkdir $@ $<
$(LIB_DIR):
	@-mkdir $@ $@/include $@/lib $<


contact:
	$(info $(contact_ui))
	@:
