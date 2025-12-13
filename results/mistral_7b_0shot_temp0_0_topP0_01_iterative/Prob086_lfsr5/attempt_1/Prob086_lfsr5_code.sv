
module TopModule (
  input clk,
  input reset,
  output reg [4:0] q
);

// Maximal-Length LFSR Polynomial for a 5-bit register: x^5 + x^3 + 1
reg [4:0] lfsr = 5'b10101; // Initial value of the LFSR

always @(posedge clk or posedge reset) begin
    if (reset) begin
        q <= 5'b1; // Reset output to 1 when reset is active-high
    end else begin
        lfsr <= {lfsr[4:2], lfsr[0] ^ lfsr[4]}; // Shift LFSR right and XOR tap bits
        q <= lfsr; // Assign output to current state of the LFSR
    end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
