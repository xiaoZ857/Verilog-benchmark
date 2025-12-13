
module TopModule (
  input wire clk,
  input wire reset,
  output reg [31:0] q
);

// Initialize the LFSR with seed value 32'h1
reg [31:0] lfsr = 32'h1;

always @(posedge clk) begin
  if (reset) begin
    q <= 32'h1; // Reset output to 32'h1 when reset is active high
    lfsr <= 32'h1; // Reset LFSR to its initial state
  end else begin
    // Shift the LFSR right and XOR with tapped bits
    lfsr <= {lfsr[30], xor_gate(lfsr[31]), xor_gate(lfsr[22]), xor_gate(lfsr[2]), xor_gate(q[0])};
    q <= lfsr; // Assign the shifted LFSR to output q
  end
end

// XOR gate function
function bit xor_gate (input a);
  return a ^ ~a;
endfunction

endmodule

// VERILOG-EVAL: errant inclusion of module definition
