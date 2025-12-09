
module TopModule(
    input [7:0] signed_in, // Signed 8-bit input
    output [31:0] signed_out  // Signed 32-bit output
);

    always @(posedge clk) begin
        signed_out = {
            signed_in[7], {signed_in[6:0]}, // Sign extension
            signed_in
        };
    end

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
