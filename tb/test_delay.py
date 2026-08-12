#cocotb based hardware verification script 
import os 
import random

import cocotb 
from cocotb.clock import Clock 
from cocotb.triggers import FallingEdge, ReadOnly, RisingEdge, Timer
from delay_model import expected_out 




#helper functions
def read_int(sig, name): 
    #help find fails 
    raw = str(sig.value)
    if "x" in raw.lower() or 'x' in raw.lower(): 
        raise AssertionError(f"{name} is not resolvable: {raw}")
    return int(sig.value)


async def start_clock(dut): 
    cocotb.start_soon(Clock(dut.clk, 10, unit = "ns").start())

async def apply_reset(dut, cycles = 3): 
    dut.reset.value = 1
    dut.in_data.value = 0 
    for _ in range(cycles): 
        await RisingEdge(dut.clk)
    await FallingEdge(dut.clk)
    dut.reset.value = 0










@cocotb.test()
async def test_delay_module(dut): 
    # start 10ns clock 
    cocotb.start_soon(Clock(dut.clk, 10, unit = "ns").start())

    #reset the circuit 
    dut.reset.value = 1 
    dut.in_data.value = 0 
    # wait for 3 clock cycles during reset 
    for _ in range (3): 
        await RisingEdge(dut.clk)
    dut.reset.value = 0 
    await FallingEdge(dut.clk) 

    #detect the depth of the delay block from the compiled hardware

    depth = int(dut.DEPTH.value)
    dut._log.info(f"Testing delay module with detected depth of:{depth}")
    #prep test variables
    test_inputs = [10, 20, 30, 40, 40, 60, 70, 80]
    history = [] 

    #drive inputs and check outputs 
    for i in range(12): 
        current_input = test_inputs[i] if i < len(test_inputs) else 0
        dut.in_data.value = current_input
        history.append(current_input)

        await RisingEdge(dut.clk)
        observed_output = int(dut.out_data.value)

        if i < depth: 
            expected_output = 0
        else : 
            expected_output = history[i  - depth] 



        dut._log.info(f"Cycle {i}: In={current_input} | Out={observed_output} (Expected={expected_output})")
        assert observed_output == expected_output, f"Mismatch at cycle {i}! Got {observed_output}, expected {expected_output}"

    dut._log.info("All delay tracking tests passed successfully!")



