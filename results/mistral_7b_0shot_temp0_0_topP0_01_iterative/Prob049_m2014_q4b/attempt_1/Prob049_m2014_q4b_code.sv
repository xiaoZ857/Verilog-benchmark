
module TopModule (
  input wire clk,
  input wire d,
  input wire ar,
  output logic q
);

reg internal q_reg; // Internal register for storing the Q value

always @(posedge clk) begin
  if (!ar) begin // If asynchronous reset is high, set Q to 0
    q_reg <= 0;
  end else begin // Else, assign the input D to the internal register
    q_reg <= d;
  end
end

assign q = q_reg; // Assign the internal register's value to the output Q

endmodule

// VERILOG-EVAL: errant inclusion of module definition
