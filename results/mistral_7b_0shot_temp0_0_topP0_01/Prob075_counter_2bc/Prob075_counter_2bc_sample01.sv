
module TopModule (
  input wire clk,
  input wire areset,
  input wire train_valid,
  input wire train_taken,
  output logic [1:0] state
);

reg [1:0] counter; // Declare a register for the counter
always @(posedge clk) begin
  if (areset) begin // On positive edge of clock when areset is high
    counter <= 2'b01; // Reset the counter to weakly not-taken (2'b01)
  end else if (train_valid && train_taken) begin // If training and taken is high
    counter <= counter + 1; // Increment the counter
    if (counter > 3'b11) counter <= 3'b11; // Saturate the counter at 3
  end else if (train_valid && !train_taken) begin // If training and taken is low
    counter <= counter - 1; // Decrement the counter
    if (counter < 2'b00) counter <= 2'b00; // Saturate the counter at 0
  end
end

assign state = counter; // Assign the counter value to output state

endmodule

// VERILOG-EVAL: errant inclusion of module definition
