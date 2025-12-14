
module TopModule (
    input [7:0] in,
    output reg [2:0] pos
);

always @(posedge clk) begin
    pos <= 3'bz; // initialize output to zero

    for (int i = 0; i < 8; i++) begin
        if (in[i]) begin
            if (pos == 3'bz) begin // if any bit is set and the output was zero before, update the output
                pos <= i + 1'b0; // add one to the index to get the correct position (zero-based to one-based)
            end
        end
    end
end

// Optional: Add a reset signal if needed
always @(posedge reset) begin
    if (reset) begin
        pos <= 3'bz; // set output to zero on reset
    end
end

// Clock and reset inputs, replace 'clk' and 'reset' with your actual clock and active-low reset signals
input clk, reset;

// Add the clock and reset pins to the module port list
output reg [2:0] pos, input clk, reset;

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
