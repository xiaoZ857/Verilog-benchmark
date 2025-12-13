
module TopModule (
  input [1:0] A,
  input [1:0] B,
  output reg z
);

always @(posedge clk) begin
  if ((A[1] == B[1]) && (A[0] == B[0])) begin
    z <= 1'b1;
  end else begin
    z <= 1'b0;
  end
end

initial begin
  // Reset the circuit at time 0
  #0 z <= 1'b0;
end

// Synchronize inputs with clock if needed
assign A = A;
assign B = B;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
