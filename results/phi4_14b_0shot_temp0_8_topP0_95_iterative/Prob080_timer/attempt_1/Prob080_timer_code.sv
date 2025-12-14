
module TopModule (
  input wire clk,
  input wire load,
  input wire [9:0] data,
  output reg tc // use 'reg' for outputs driven by procedural assignments
);

  reg [9:0] counter; // internal register to hold the countdown value

  always @(posedge clk) begin
    if (load) begin
      // Load new value into the counter when load signal is high
      counter <= data;
      tc <= 0; // reset terminal count since we have a new value
    end else begin
      if (counter > 0) begin
        // Decrement the counter as long as it's greater than 0 and load is not asserted
        counter <= counter - 1;
        tc <= 0; // keep terminal count low while counting down
      end else begin
        // If counter reaches zero, assert terminal count
        tc <= 1;
      end
    end
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
