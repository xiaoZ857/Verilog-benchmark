
module TopModule (
  input clk,
  input in,
  input reset,
  output out
);
 ```verilog
reg [1:0] state;
always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 2'b00;
    else if (state == 2'b00)
        state <= 2'b01;
    else if (state == 2'b01 && in == 0)
        state <= 2'b10;
    else if (state == 2'b01 && in == 1)
        state <= 2'b01;
    else if (state == 2'b10)
        state <= 2'b11;
    else if (state == 2'b11 && in == 0)
        state <= 2'b00;
    else if (state == 2'b11 && in == 1)
        state <= 2'b01;
end
assign out = state[0];
endmodule

// VERILOG-EVAL: abnormal backticks count
