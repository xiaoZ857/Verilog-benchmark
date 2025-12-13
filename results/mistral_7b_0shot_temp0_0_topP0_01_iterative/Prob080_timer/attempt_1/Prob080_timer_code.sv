
module TopModule (
  input clk,
  input load,
  input [9:0] data,
  output tc
);
module Timer(
    input clk,
    input load,
    input [9:0] data,
    output reg tc
);

reg [9:0] counter; // 10-bit internal counter

always @(posedge clk) begin
    if (load) begin
        counter <= data; // Load the counter with the given data when load is high
    end
    if (counter == 0 && !load) begin // Check if the counter has reached 0 and load is low
        tc <= 1'b1; // Assert tc when the counter reaches 0
    end
    if (!load) begin // Decrement the counter on every clock cycle when load is low
        counter <= counter - 1;
    end
end

initial begin
    counter <= 10'b0000000000; // Initialize the counter to 0 by default
end

endmodule
