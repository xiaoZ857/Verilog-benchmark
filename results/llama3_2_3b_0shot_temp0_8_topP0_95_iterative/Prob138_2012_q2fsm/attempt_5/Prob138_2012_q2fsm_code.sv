
module TopModule (
    input clk,
    input reset,
    input w,
    output reg z
);

// State flip-flops
reg [1:0] state;

// Reset logic
always @(posedge clk)
if(reset) 
state <= 2'b00;

// State table
always @(*)
case(state)
    2'b00: if(w == 0) next_state = 2'b01; else next_state = 2'b00;
    2'b01: if(w == 1) next_state = 2'b10; else next_state = 2'b01;
endcase
assign state = next_state;

// Output mapping
reg [6:0] z_prev, z_next;

always @(*)
case(state)
    2'b00: 
        z_prev = {4'b0000, 3'd0, 3'd1, 3'd2};
        z_next = {4'b0010, 3'd0, 3'd1, 3'd2};
    2'b01:
        z_prev = {4'b0100, 3'd2, 3'd3, 3'd4};
        z_next = {4'b0110, 3'd2, 3'd3, 3'd4};
    2'b10:
        z_prev = {4'b1000, 3'd4, 3'd5, 3'd6};
        z_next = {4'b1010, 3'd4, 3'd5, 3'd6};
endcase

// Output assignment
always @(posedge clk)
if(reset) 
    z <= z_prev;
else
    if(w == 1) z <= z_next; else z <= z_prev;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
