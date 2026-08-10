SIM ?= icarus
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCES += $(PWD)/delay.sv
TOPLEVEL = delay
MODULE   = test_delay

COMPILE_ARGS += -g2012
COMPILE_ARGS += -Pdelay.DEPTH=4
WAVES = 1

include $(shell cocotb-config --makefiles)/Makefile.sim