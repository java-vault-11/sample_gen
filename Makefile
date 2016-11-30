.PHONY: all help cpu-usage

ifeq ($(num), )
  Num=100
else
  Num=$(num)
  echo hello
  echo $(Num)
endif

all: help

help:
	echo usage@COLON@ make cpu-usage [verbose=true] [num=N]

cpu-usage:
ifeq ($(verbose), true)
	./cpu_usage_gen.escript --verbose $(Num)
else
	./cpu_usage_gen.escript $(Num)
endif
