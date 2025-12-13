
module TopModule (
  input clk,
  input load,
  input [9:0] data,
  output reg tc
);

  // Internal register to hold the current counter value
  reg [9:0] counter;

  always @(posedge clk) begin
    if (load) begin
      // Load the new count value into the counter
      counter <= data;
      // Reset terminal count signal when loading a new value
      tc <= 0;
    end else begin
      if (counter > 0) begin
        // Decrement the counter if it's greater than zero
        counter <= counter - 1;
      end
      // Assert terminal count signal when counter reaches zero
      if (counter == 0) begin
        tc <= 1;
      end
    end
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
