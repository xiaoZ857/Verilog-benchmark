
// Implement the Verilog module based on the following description. Assume that signals are positive clock/clk triggered unless otherwise stated.
// Parity checking is often used as a simple method of detecting errors when transmitting data through an imperfect channel. Create a circuit that will compute a parity bit for a 8-bit byte (which will add a 9th bit to the byte). We will use "even" parity, where the parity bit is just the XOR of all 8 data bits.

always @(posedge clk or posedge resetn) begin
    if (resetn)
        parity <= 1'b0; // Initializing parity as 0 for the first clock cycle
    else if (!resetn)
        parity <= ~in; // Initializing parity as inverse of all inputs for the first clock cycle
    else
        parity <= ~parity ^ in; // XOR operation to calculate even parity for the rest of the clock cycles
end

always @(negedge clk) begin
    if (!resetn) // Only update parity on the falling edge of the clock when resetn is not active
        parity <= parity ^ in; // XOR operation to calculate even parity for the rest of the clock cycles
end

// Module body code
module TopModule (
  input [7:0] in,
  output parity
);

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
