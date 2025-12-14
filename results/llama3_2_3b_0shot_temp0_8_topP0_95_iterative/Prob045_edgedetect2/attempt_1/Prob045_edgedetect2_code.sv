
module TopModule(
    // Clock signal
    input clk,

    // Input 8-bit vector
    input [7:0] in,

    // Output 8-bit vector to store any edge detection
    output reg [7:0] anyedge
);

// Instantiate a D flip-flop for each bit of the input vector
reg[7:0] edges[8];

assign anyedge = edges;

always @(posedge clk) begin

    // Flip through the input vector
    edges[0] <= in;
    
    for (int i = 1; i < 8; i++) begin
        edges[i] <= edges[i-1];
    end

end

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
