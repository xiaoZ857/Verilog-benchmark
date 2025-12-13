
module TopModule (
  input clk,
  input d,
  input ar,
  output logic q
);
reg internal q_reg; // Internal register for storing the Q value

always @(posedge clk or negedge ar) begin
  if (ar === 1'b1) begin // If asynchronous reset is high, set Q to 0
    q_reg <= 0;
  end else if (posedge clk) begin // Else, assign the input D to the internal register on positive edge of clk
    q_reg <= d;
  end
end

assign q = q_reg; // Assign the internal register's value to the output Q

endmodule
