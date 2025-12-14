
module TopModule (
    input [4:1] x,
    output logic f
);

logic [3:0][2:0] y;

assign y[2] = (x[3] == 1) ? x[2]: x[3];
assign y[1] = ~(y[2]);
assign y[0] = (x[3] == 0) || (x[2] == 1);

logic f;
assign f = 
    (~x[4]) & y[3]
    | (x[2] == 1) & x[1]
    | ~(x[3] & ~y[0])
    | (x[0] == 0) & y[2];

endmodule

// VERILOG-EVAL: errant inclusion of module definition
