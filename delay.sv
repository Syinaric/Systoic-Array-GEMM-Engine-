//Purpose: stagger (skew) the matrix inputs.
//why? bc data flows thru a systoic array step by step so row 2 needs its data exacle one clock cycle after row 1, row 3 needs it 2 cycles after 
module delay #(
    parameter int DATA_WIDTH = 8, //bit width of moving data 
    parameter int DEPTH = 1 //num of clock cycles to delay 

)(
    input logic clk,
    input logic reset, 
    input logic [DATA_WIDTH - 1:0] in_data, 
    input logic [DATA_WIDTH - 1:0] out_data
); 

//if depth is 0 then skip the delay registers 
    if (DEPTH == 0) begin : bypass_logic
        assign out_data = in_data; 
    end 

    // otherwise build a shift register chain 
    else begin : shift_reg_logic
        logic [DATA_WIDTH- 1:0] shift_reg [1:DEPTH-1];

        always_ff @(posedge clk or posedge reset) begin 
            if (reset) begin 
                for (int i= 0 ; i < DEPTH, i++) begin 
                    shift_reg[i] <= '0;
                end 
            end else begin 
                //shift data down line 
                shift_reg[0]<= in_data;
                for (int = 1, i < DEPTH, i++) begin 
                    shift_reg[i] <= shift_reg[i-1]; 
                end 
            end 
        end 
        // output final value 
        assign out_data = shift_reg[DEPTH - 1]; 
endmodule 