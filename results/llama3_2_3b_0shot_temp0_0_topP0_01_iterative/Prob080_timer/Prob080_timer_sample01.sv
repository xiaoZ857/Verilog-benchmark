
module TopModule (
  input clk,
  input load,
  input [9:0] data,
  output tc
);
reg [9:0] counter;
reg [9:0] current_count;

always @(posedge clk) begin // Clock edge triggered
    if (load == 1) begin // Load new value into the counter
        counter <= data;
        current_count <= counter; // Store the current count
    else if (counter != 0 && current_count > 0) begin // Decrement the counter
        current_count <= current_count - 1;
    end
end

assign tc = (current_count == 0); // Output signal indicating whether the timer has expired

always @(posedge clk or load) begin // Clock edge triggered and/or load event
    if (load == 1) begin // Load new value into the counter
        current_count <= 0; // Reset the counter when loading a new value
    end
end

// VERILOG-EVAL: endmodule not found
