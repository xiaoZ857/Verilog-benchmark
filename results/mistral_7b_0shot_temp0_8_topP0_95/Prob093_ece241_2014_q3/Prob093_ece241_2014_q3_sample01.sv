
module TopModule (
  input c,
  input d,
  output [3:0] mux_in
);

// Define the 2-to-1 Multiplexer
logic [1:0] sel_2to1;
logic [1:0] data_2to1;
input a, b;
output y_2to1;

// Define the 4-to-1 Multiplexer
logic [3:0] sel_4to1;
logic [3:0] data_4to1;
output y_4to1;

// Instantiate two 2-to-1 multiplexers
mux2to1: mux2to1_instance (
    .a(a),
    .b(b),
    .sel_2to1(sel_2to1),
    .data_2to1(data_2to1),
    .y_2to1(y_2to1)
);

mux4to1: mux4to1_instance (
    .a(sel_2to1[0]),
    .b(sel_2to1[1]),
    .cd(c, d),
    .data_4to1(data_2to1),
    .y_4to1(mux_in)
);

// Define the truth table for 2-to-1 multiplexers
always_comb begin
    case (sel_2to1)
        00 : data_2to1 <= 0;
        01 : data_2to1 <= 1;
        11 : data_2to1 <= c;
        10 : data_2to1 <= d;
    endcase
end

// Define the truth table for 4-to-1 multiplexers (based on given Karnaugh map)
always_comb begin
    sel_4to1[3] = a & b;
    sel_4to1[2] = ~b;
    sel_4to1[1] = c | (a & ~b);
    sel_4to1[0] = d | (~c & ~a);
end

// Assign the inputs for the top-level module
assign a = sel_4to1[2];
assign b = sel_4to1[3];

endmodule

// VERILOG-EVAL: errant inclusion of module definition
