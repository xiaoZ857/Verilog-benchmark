
module TopModule (
  input clk,
  input load,
  input [9:0] data,
  output tc
);
reg[10:0] counter;     // 11-bit down-counter
reg initialized = 1;

always @(posedge clk) begin
    if(load) begin
        // Load the timer duration into the counter
        counter = data;
        // Reset the flag to prevent counting until new value is loaded
        initialized = 0;
    end else if (initialized == 1) begin
        // Decrement the counter by 1
        counter <= counter - 1;
    end 
end

always @(posedge clk or load) begin
    if(load) begin
        initialized = 0;
    end 
    tc = (counter[10:0] == 0);
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
