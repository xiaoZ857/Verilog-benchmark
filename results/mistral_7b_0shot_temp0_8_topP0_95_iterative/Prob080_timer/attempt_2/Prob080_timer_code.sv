
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

reg [9:0] counter; // Counter must be initialized

always @(posedge clk) begin
    if (load) begin
        if(counter == [9:0]'bz) // Load the counter with the given data
            counter <= data;
        tc <= 1'b0; // Reset the terminal count signal
    end
    if (counter > 0) begin
        counter <= counter - 1'b1; // Decrement the counter
    end
    if (counter == 0) begin
        tc <= 1'b1; // Assert terminal count signal
    end
end

endmodule
