
module TopModule (
  input clk,
  input reset,
  input data,
  output start_shifting
);
always @(posedge clk) begin
    if (reset) begin
        current_state <= S0;
        start_shifting <= 0;
    end else case (current_state)
        S0:
            if (data == 1) current_state <= S1;
            else           current_state <= S0;
        S1:
            if (data == 1) current_state <= S2;
            else           current_state <= S0;
        S2:
            if (data == 0) current_state <= S3;
            else           current_state <= S1;
        S3:
            if (data == 1) begin
                current_state <= S4;
                start_shifting <= 1;
            end else current_state <= S0;
        S4:
            current_state <= S4; // Stay in state once sequence is found
    endcase
end

wire data; // Input from the bit stream
reg current_state = S0;
reg start_shifting = 0;

endmodule
