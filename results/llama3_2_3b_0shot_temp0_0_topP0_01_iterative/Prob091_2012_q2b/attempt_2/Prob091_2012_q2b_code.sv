
module TopModule (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

// State machine encoding
localparam [6:0] A = 8'h000001;
localparam [6:0] B = 8'h000010;
localparam [6:0] C = 8'h000100;
localparam [6:0] D = 8'h001000;
localparam [6:0] E = 8'h010000;
localparam [6:0] F = 8'h100000;

// State machine logic
assign Y1 = (y == A) ? w : (y == B) ? w : (y == C) ? w : (y == D) ? w : (y == E) ? w : (y == F);
assign Y3 = (y == E) ? w : (y == F) ? w : (y == D) ? w : (y == C) ? w : (y == B) ? w : (y == A);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
