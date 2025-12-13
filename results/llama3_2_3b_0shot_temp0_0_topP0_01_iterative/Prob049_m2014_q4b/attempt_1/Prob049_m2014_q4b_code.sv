
module TopModule (
  input clk,
  input d,
  input ar,
  output logic q
);

// Define the internal state variable
logic [1:0] state;

// Initialize the state to 0 (default value)
assign state = 0;

// Positive edge-triggered D flip-flop with asynchronous reset
always @(posedge clk) begin
    if (ar) begin // Asynchronous reset
        state <= 0;
    else if (d) begin // Set input
        state <= d;
    end
end

// Output the current state
assign q = state;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
