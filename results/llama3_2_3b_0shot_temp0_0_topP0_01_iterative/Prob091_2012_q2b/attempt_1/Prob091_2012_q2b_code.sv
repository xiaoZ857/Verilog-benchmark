
module TopModule(
    input [5:0] y, // One-hot encoded state
    input w,      // Write signal
    output Y1,    // Input of state flip-flop y[1]
    output Y3     // Input of state flip-flop y[3]
);

// State machine encoding
localparam [5:0] A = 8'h000001;
localparam [5:0] B = 8'h000010;
localparam [5:0] C = 8'h000100;
localparam [5:0] D = 8'h001000;
localparam [5:0] E = 8'h010000;
localparam [5:0] F = 8'h100000;

// State machine logic
assign Y1 = (y == A) ? w : (y == B) ? w : (y == C) ? w : (y == D) ? w : (y == E) ? w : (y == F);
assign Y3 = (y == E) ? w : (y == F) ? w : (y == D) ? w : (y == C) ? w : (y == B) ? w : (y == A);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
