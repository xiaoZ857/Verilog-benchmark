
module TopModule (
    input wire clk,
    input wire reset,
    output reg [9:0] q
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        q <= 10'b0000000000; // Reset the counter to 0
    end else begin
        if (q >= 10'd999) begin
            q <= 10'b000; // Wraparound to 0 when reaching 999
        end else begin
            q <= q + 1; // Increment the counter
        end
    end
end

// For synthesis
initial begin
    $dumpfile("top_module.vcd");
    $dumpvars(0, topModule);
    #1000 end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
