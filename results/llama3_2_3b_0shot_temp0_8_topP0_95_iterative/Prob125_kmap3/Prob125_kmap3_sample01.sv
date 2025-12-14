
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output reg out
);
// Create local variables to represent each state in the table
reg [1:0] abcd = 2'b00; // Initial state

always @(posedge clk) begin
    // Map abcd to the corresponding output value
    if (abcd == 2'b00)
        out <= d;
    else if (abcd == 2'b01)
        out <= a & ~d;
    else if (abcd == 2'b10)
        out <= a | ~d;
    else if (abcd == 2'b11)
        out <= a & ~d;

// Karnaugh map based on the input values
reg [3:0] abcd_state = {a, b, c, d};

assign abcd_state[1:0] = {abcd_state[3], ~(d & ~abcd_state[2])};

// State sequence table
reg [4:0] seq = 5'b00000;

always @(posedge clk) begin
    if (seq == 4'b1111)
        seq <= 5'b10001;
    else if ((seq[2] == 1 && seq[3] == 1) || (seq[4] == 1))
        seq <= 5'b01000;

    // Update the state sequence table
    if (seq[0])
        seq <= {1'b0, seq[1], seq[2], seq[3]};
    else if (seq[1])
        seq <= {1'b1, seq[0], seq[2], seq[3]};
    else if (~seq[2] || ~seq[3])
        seq <= 5'b11000; // Reset sequence
end

// Select the correct output value based on abcd_state and seq
assign out = (abcd_state == seq) ? a | b | c & d : 1;

endmodule
