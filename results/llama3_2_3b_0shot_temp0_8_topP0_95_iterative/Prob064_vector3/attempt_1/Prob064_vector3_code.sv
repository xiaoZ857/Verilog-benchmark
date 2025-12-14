
// Concatenate and Split Input Vectors to Output Vectors

module TopModule (
    input [4:0] a,
    input [4:0] b,
    input [4:0] c,
    input [4:0] d,
    input [4:0] e,
    input [4:0] f,
    
    output reg [7:0] w,
    output reg [7:0] x,
    output reg [7:0] y,
    output reg [7:0] z
);

// Shift input vectors 24 bits to the left for vector concatenation
assign w = ({a[4], b[4], c[4], d[4], e[4], f[4], 1'b1, 1'b1});
assign x = {{a[4], b[4], c[4], d[4], e[4], f[4], 1'b1, 1'b1}};
assign y = {x};
assign z = {y};

endmodule

// VERILOG-EVAL: errant inclusion of module definition
