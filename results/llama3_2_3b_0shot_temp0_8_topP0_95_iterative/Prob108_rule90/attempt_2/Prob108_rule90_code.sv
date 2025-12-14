
initial begin
    q <= 1'b0;
    for (int i = 0; i < 512; i++) 
        next_state[i][0:1] = rule_90_center[i + 1];
    for (int i = 0; i < 512; i++)
        if ((i > 0) && (i < 511))
            next_state[i][2] = rule_90_left[i + 1];
        else
            next_state[i][2] = 1'b0;
end

always @(posedge clk)
begin
    current_state <= next_state;

    for (int i = 0; i < 512; i++)
        if ((i > 0) && (i < 511))
            q[i + 1] <= ~current_state[i][2] & current_state[i - 1][0] ^ current_state[i + 1][0];
        else
            q[i] <= ~current_state[i][2];

    if (load)
        q <= data[511:1];

    for (int i = 0; i < 512; i++)
        if ((i > 0) && (i < 511))
            next_state[i - 1][2] = rule_90_right[511];
        else
            next_state[i - 1][2] = 1'b0;
end

for (int i = 0; i < 512; i++)
    if ((i > 0) && (i < 511))
        q[i + 1] <= ~current_state[i - 1][2];

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
