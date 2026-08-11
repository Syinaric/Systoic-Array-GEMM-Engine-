SIM ?= icarus
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCES += $(PWD)/rtl/delay.sv
TOPLEVEL = delay
MODULE   = test_delay

COMPILE_ARGS += -g2012
COMPILE_ARGS += -Pdelay.DEPTH=4
WAVES = 1

include $(shell cocotb-config --makefiles)/Makefile.sim
export PYTHONPATH := $(PWD)/tb:$(PWD)/model:$(PYTHONPATH)