
module TopModule (
  input in,
  input [3:0] state,
  output reg [3:0] next_state,
  output out
);
assign next_state = {in & (state == 4'b0001),
                      (state != 4'b0001) & (state == 4'b0010),
                      (state != 4'b0010) & (state == 4'b0100),
                      (state != 4'b0100) & (state == 4'b1000)};

assign out = {in & ~(state == 4'b0001),
                ~in & (state == 4'b0010),
                (in | ~state == 4'b0010) & (state == 4'b0100),
                in & (state == 4'b1000)};

// VERILOG-EVAL: endmodule not found
