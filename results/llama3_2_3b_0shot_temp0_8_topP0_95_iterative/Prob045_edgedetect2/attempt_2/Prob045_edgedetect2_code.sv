
module TopModule(
    // Clock signal
    input clk,

    // Input 8-bit vector
    input [7:0] in,

    // Output 8-bit vector to store any edge detection
    output reg [7:0] anyedge
);

reg[7:0] edges[8];

assign anyedge = edges[0];

always @(posedge clk) begin

    if(in != edges[0]) begin
        edges[0] <= in;
    end else begin
        edges[0] <= edges[0];
    end

    for (int i = 1; i < 8; i++) begin
        if(edges[i-1] != edges[i]) begin
            edges[i] <= in;
        end else begin
            edges[i] <= edges[i];
        end
    end

end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
