
module TopModule (
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q
);
always @(posedge clk or load)
begin
    current_state <= next_state;

    for (int i = 0; i < 512; i++)
        if ((i > 0) && (i < 511))
            q[i + 1] <= ~current_state[i][2] & current_state[i - 1][0] ^ current_state[i + 1][0];
        else
            q[i] <= ~current_state[i][2];

    if (load)
        q[511:1] <= data[511:1];

    for (int i = 0; i < 512; i++)
        if ((i > 0) && (i < 511))
            next_state[i - 1][2] = rule_90_right[i];
        else
            next_state[i - 1][2] = 1'b0;
end

for (int i = 0; i < 512; i++)
    if ((i > 0) && (i < 511))
        q[i + 1] <= ~current_state[i - 1][2];

// VERILOG-EVAL: endmodule not found
