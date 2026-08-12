SIM ?= icarus
TOPLEVEL_LANG ?= verilog

DEPTH ?= 4
DATA_WIDTH ?= 8
SEED ?=
export SEED

VERILOG_SOURCES += $(PWD)/RTL/delay.sv

COCOTB_TOPLEVEL       = delay
COCOTB_TEST_MODULES   = test_delay

export PYTHONPATH := $(PWD)/tb:$(PWD)/model:$(PYTHONPATH)

COMPILE_ARGS += -g2012
COMPILE_ARGS += -Pdelay.DEPTH=$(DEPTH)
COMPILE_ARGS += -Pdelay.DATA_WIDTH=$(DATA_WIDTH)
SIM_BUILD = sim_build/depth_$(DEPTH)

include $(shell cocotb-config --makefiles)/Makefile.sim

.PHONY: sweep
sweep:
	@for d in 0 1 2 4 8; do \
	  echo "=== DEPTH=$$d ==="; \
	  $(MAKE) -s DEPTH=$$d || exit 1; \
	done
	@echo "=== sweep passed ==="