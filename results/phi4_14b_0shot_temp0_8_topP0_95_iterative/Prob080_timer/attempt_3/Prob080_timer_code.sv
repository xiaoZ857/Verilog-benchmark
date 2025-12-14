
module TopModule (
  input clk,
  input load,
  input [9:0] data,
  output tc
);
always @(posedge clk) begin
  if (load) begin
    // Load new value into the counter when load signal is high
    counter <= data;
    tc <= 0; // Ensure terminal count is low after loading a new value
  end else begin
    if (counter > 0) begin
      // Decrement the counter as long as it's greater than 0 and load is not asserted
      counter <= counter - 1;
      tc <= 0; // Keep terminal count low while counting down
    end else begin
      // If counter reaches zero, assert terminal count
      // When load is false (no new value loaded), maintain tc as high
      tc <= !load; 
    end
  end
end


// VERILOG-EVAL: abnormal backticks count
