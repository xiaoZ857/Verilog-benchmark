
module TopModule (
  input clk,
  input load,
  input [9:0] data,
  output tc
);
module TimerTopModule(
    input clk,        // Clock input
    input load,        // Load signal to update counter value
    input [9:0] data,   // Initial value for the counter
    output tc         // Terminal count ( asserted when counter reaches 0 )
);

// Internal counter
reg [10:0] counter;

// Initialize counter with initial data
initial begin
    counter = data;
end

always @(posedge clk) begin
    if(load == 1) begin
        // Load the internal counter with the given value
        counter = data;
    else begin
        // Decrement the internal counter by 1 (wrapping around to 0 when it reaches 0)
        counter = counter - 1;
    end
end

always @(*) begin
    tc = (counter == 0);
end

// VERILOG-EVAL: endmodule not found
