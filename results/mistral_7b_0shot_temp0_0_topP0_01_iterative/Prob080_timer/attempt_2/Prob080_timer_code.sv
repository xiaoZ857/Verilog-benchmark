
module TopModule (
  input clk,
  input load,
  input [9:0] data,
  output tc
);
always @(posedge clk or negedge load) begin
    if (load) begin
        if (counter >= 10'd0) // Ensure counter can hold the data
            counter <= data; // Load the counter with the given data when load is high
    end
    if (counter > 0 && !load) begin // Check if the counter has not reached 0 and load is low
        counter <= counter - 1;
        if (counter == 0)
            tc <= 1'b1; // Assert tc when the counter reaches 0
    end
end

initial begin
    counter <= 10'b0; // Initialize the counter to 0 by default
end

// VERILOG-EVAL: endmodule not found
