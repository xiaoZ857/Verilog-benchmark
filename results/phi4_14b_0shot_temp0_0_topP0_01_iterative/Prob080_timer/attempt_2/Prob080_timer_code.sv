
module TopModule (
  input clk,
  input load,
  input [9:0] data,
  output tc
);
always @(posedge clk) begin
  if (load) begin
    // Load the new count value into the counter
    counter <= data;
    // Reset terminal count signal when loading a new value
    tc <= 0; // This ensures `tc` is reset only on load
  end else begin
    if (counter > 0) begin
      // Decrement the counter if it's greater than zero
      counter <= counter - 1;
    end
    // Assert terminal count signal when counter reaches zero
    if (counter == 0) begin
      tc <= 1; // Set `tc` to 1 when counter is zero
    end
  end
end


// VERILOG-EVAL: endmodule not found
