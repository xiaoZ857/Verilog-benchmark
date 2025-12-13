
module TopModule (
  input clk,
  input load,
  input [9:0] data,
  output tc
);

always @(posedge clk) begin
  if (load) begin
    counter <= data;
  end else if (counter != 0) begin
    counter <= counter - 1;
  end
  // If counter is 0 and not loading, keep it at 0
end

assign tc = (counter == 0);

endmodule
