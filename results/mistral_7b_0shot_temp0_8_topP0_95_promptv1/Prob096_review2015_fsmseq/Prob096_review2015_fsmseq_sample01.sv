
module TopModule (
  input clk,
  input reset,
  input data,
  output start_shifting
);
 ```verilog
reg [3:0] current_state;
reg start_shifting;

always @(posedge clk or posedge reset) begin
    if (reset)
        start_shifting <= 0;
    else if (current_state === 4'b0110 && data === 1) begin
        current_state <= 4'b1101;
        start_shifting <= 1;
    end else
        current_state <= {current_state[2:0], data};
end

assign start_shifting; // wire output declared as reg in module header

endmodule

// VERILOG-EVAL: abnormal backticks count
