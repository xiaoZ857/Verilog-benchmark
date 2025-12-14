
module TopModule (
    input clk,
    input reset,
    input w,
    output [7:0] z
);

// Define the signal names
localparam [4:0] A = 2'b00;
localparam [4:0] B = 2'b01;
localparam [4:0] C = 2'b10;
localparam [4:0] D = 2'b11;
localparam [4:0] E = 2'b12;
localparam [4:0] F = 2'b13;

// Define the state table
always @(*)
    case(state)
        A:      if(w == 1) next_state = B; else next_state = A;
        B:      if(w == 1) next_state = C; else next_state = D;
        C:      if(w == 1) next_state = E; else next_state = D;
        D:      if(w == 1) next_state = F; else next_state = A;
        E:      next_state = E;
        F:      next_state = C;
    endcase

// State flip-flops
reg [4:0] state;
reg [1:0] next_state;

always @(posedge clk)
    if(reset) 
        state <= A; 
    else
        state <= next_state;

assign z = {state[2], state[3], state[4], state[5], state[6], state[7]};

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
