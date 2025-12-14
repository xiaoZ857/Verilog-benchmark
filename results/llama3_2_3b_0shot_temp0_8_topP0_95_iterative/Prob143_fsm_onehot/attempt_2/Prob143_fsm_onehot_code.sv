
module TopModule (
  input in,
  input [9:0] state,
  output [9:0] next_state,
  output out1,
  output out2
);
always @(posedge clk or !in) begin
  next_state[9:0] = state;
  
  if (state[8:7] == {2'b00, 2'b00}) begin // S0
    out1 <= 0;
    out2 <= 0;
  end else if (state[8:7] == {2'b01, 2'b00}) begin // S1
    out1 <= 0;
    out2 <= 0;
  end else if (state[8:7] == {2'b10, 2'b00}) begin // S2
    out1 <= 0;
    out2 <= 0;
  end else if (state[8:7] == {2'b11, 2'b00}) begin // S3
    out1 <= 0;
    out2 <= 0;
  end else if (state[8:7] == {2'b00, 2'b01}) begin // S4
    out1 <= 0;
    out2 <= 0;
  end else if (state[8:7] == {2'b01, 2'b01}) begin // S5
    out1 <= 0;
    out2 <= 0;
  end else if (state[8:7] == {2'b10, 2'b01}) begin // S6
    out1 <= 0;
    out2 <= 0;
  end else if (state[8:7] == {2'b11, 2'b01}) begin // S7
    out1 <= 0;
    out2 <= 0;
  end else if (state[8:7] == {2'b00, 2'b10}) begin // S8
    out1 <= 0;
    out2 <= 0;
  end else if (state[8:7] == {2'b01, 2'b10}) begin // S9
    out1 <= 0;
    out2 <= 0;
  end else if (state[8:7] == {2'b11, 2'b10}) begin // S6 and S7 with in = 1
    out1 <= state[15]; //S6 or S7
    out2 <= state[14]; //S6 or S7
  end else if (state[8:7] == {2'b00, 2'b11}) begin // S3 and S4 with in = 0
    out1 <= state[13]; //S3 or S4
    out2 <= state[12]; //S3 or S4
  end else if (state[8:7] == {2'b01, 2'b11}) begin // S5 and S6 with in = 0
    out1 <= 0;
    out2 <= 0;
  end else if (state[8:7] == {2'b10, 2'b11}) begin // S7 and S8 with in = 0
    out1 <= state[15]; //S6 or S7
    out2 <= state[14]; //S6 or S7
  end else if (state[8:7] == {2'b11, 2'b11}) begin // S5 and S4 with in = 0
    out1 <= 0;
    out2 <= 0;
  end else // invalid state
    out1 <= 0;
    out2 <= 0;
end

// VERILOG-EVAL: endmodule not found
