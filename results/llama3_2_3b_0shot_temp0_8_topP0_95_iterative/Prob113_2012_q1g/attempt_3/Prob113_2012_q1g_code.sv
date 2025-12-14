
module TopModule (
    input [4:1] x,
    output logic f
);

logic [3:0][2:0] y;

assign y[2] = (x[3] == 1) ? x[2]: x[3];
assign y[1] = ~(y[2]);
assign y[0] = (x[4]==0)?1:((x[3]==0) || (x[2]==1));

logic temp;
assign temp = (~x[4]) & ((x[2] == 1) | (x[1]));
assign f = temp | ((~x[3]) & y[3]);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
