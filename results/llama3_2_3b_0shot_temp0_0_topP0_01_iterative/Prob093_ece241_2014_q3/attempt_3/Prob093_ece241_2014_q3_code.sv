
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

    // 2-to-1 multiplexers
    wire [1:0] a;
    wire [1:0] b;

    assign a = {c, ~d};
    assign b = {~c, d};

    // 4-to-1 multiplexer inputs
    wire [3:0] mux_in_00, mux_in_01, mux_in_11, mux_in_10;

    // Calculate mux_in values from ab and c/d
    assign mux_in_00 = a;
    assign mux_in_01 = b;
    assign mux_in_11 = {a, ~b};
    assign mux_in_10 = {~a, b};

    // 4-to-1 multiplexer with ab as selector
    wire [3:0] mux_out;
    assign mux_out = (c & d) ? mux_in_00 : 
                      (~c & d) ? mux_in_01 : 
                      (c & ~d) ? mux_in_11 : 
                      (~c & ~d) ? mux_in_10;

    // Assign mux_in values
    assign mux_in[3:0] = mux_out;

endmodule
