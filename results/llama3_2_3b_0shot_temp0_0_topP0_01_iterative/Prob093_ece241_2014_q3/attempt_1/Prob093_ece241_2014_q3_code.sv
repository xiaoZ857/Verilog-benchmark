
module TopModule (
  input c,
  input d,
  output [3:0] mux_in
);
module top_module(
    input c, 
    input d, 
    output [3:0] mux_in
);

    // 4-to-1 multiplexer inputs
    wire [2:0] ab;

    // Calculate ab from c and d
    assign ab = {c, d};

    // 2-to-1 multiplexers
    wire [1:0] a;
    wire [1:0] b;
    assign a = ab[1];
    assign b = ab[0];

    // 4-to-1 multiplexer inputs
    wire [3:0] mux_in_00, mux_in_01, mux_in_11, mux_in_10;

    // Calculate mux_in values from ab and c/d
    assign mux_in_00 = {a, b};
    assign mux_in_01 = {a, ~b};
    assign mux_in_11 = {~a, b};
    assign mux_in_10 = {~a, ~b};

    // 4-to-1 multiplexer with ab as selector
    assign mux_in[3:0] = ab[2:0] == 00 ? mux_in_00 : 
                        ab[2:0] == 01 ? mux_in_01 : 
                        ab[2:0] == 11 ? mux_in_11 : 
                        mux_in_10;

endmodule
