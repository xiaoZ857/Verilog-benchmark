
module TopModule (
  input clk,
  input d,
  input ar,
  output logic q
);
// Initialize the current state (Q)
logic [1:0] prev_q = 2'b00;

// Create a new register to hold the current state
reg [1:0] cur_q = prev_q;

// Create an asynchronous reset signal for the flip flop
logic ar_rst = ~ar; // Inverter of active low ar

// Create a clock enable signal
logic clk_en;
assign clk_en = ~ar ? 1'b0 : (clk & ~ar); // Ensure clk_en is always 1 when ar is asserted, else it's the case of normal positive edge triggered clocking

// Update the current state (Q) on the rising edge of the clock
always @(posedge clk or posedge clk_en) begin
  cur_q <= d & ar_rst ? d : prev_q;
end

// Store the updated current state in the output q
assign q = cur_q;

// Initialize the previous state with a default value (0)
initial prev_q = 2'b00;

// VERILOG-EVAL: endmodule not found
