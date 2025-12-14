
// Define the signal names
localparam [4:0] A = 2'b00;
localparam [4:0] B = 2'b01;
localparam [4:0] C = 2'b10;
localparam [4:0] D = 2'b11;
localparam [4:0] E = 2'b12;
localparam [4:0] F = 2'b13;

// Define the state table
module TopModule(
    input clk,
    input reset,
    input w,
    output z
) {
    localreg [4:0] state;
    reg [1:0] next_state;

    // State table
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
    always @(posedge clk) 
        state <= next_state;

    initial, positivelatchdown #1
        if(reset)
            state <= A;

    // FSM output
    assign z = {state[2], state[3]};
}

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
