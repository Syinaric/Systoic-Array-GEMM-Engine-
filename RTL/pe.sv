//processing element for the 8x8 output 
// one signed INT8 MAC per cycle, operands are passed east and south
//one output time is held in shadow register until the drain moves it out 

module pe #(
    parameter int DATA_WIDTH = 8, 
    parameter int ACC_WIDTH = 32 
)(
    input logic clk,
    input logic reset,
    input logic en,
    //west to east and north to south
    input logic signed  [DATA_WIDTH -1 :0] a_in,
    input logic signed  [DATA_WIDTH -1 :0] b_in,
    output logic signed [DATA_WIDTH -1 :0]a_out,
    output logic signed [DATA_WIDTH -1 :0]b_out,

    input logic first_in, 
    input logic last_in,
    output logic first_out, 
    output logic last_out,

   //drain 
    input logic drain_shift,
    input  logic signed [ACC_WIDTH-1:0]   drain_in,
    output logic signed [ACC_WIDTH-1:0]   drain_out

); 

endmodule








)