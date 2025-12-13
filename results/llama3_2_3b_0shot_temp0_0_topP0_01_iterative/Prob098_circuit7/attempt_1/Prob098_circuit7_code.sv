
// Define the TopModule with inputs, outputs and internal signals
module TopModule(
    // Clock signal
    input clk,

    // Input signal 'a'
    input a,

    // Output signal 'q'
    output reg q
);

// Initialize the output signal 'q' to 0
initial begin
    q <= 0;
end

// Define the always block for sequential logic
always @(posedge clk) begin
    if (a == 1) begin
        q <= 1;
    end else if (q == 1 && a == 0) begin
        q <= 0;
    end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
