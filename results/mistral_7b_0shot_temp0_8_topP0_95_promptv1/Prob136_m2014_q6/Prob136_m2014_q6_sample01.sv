
module TopModule (
  input clk,
  input reset,
  input w,
  output z
);
 ```verilog
reg [1:0] state;
always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 2'b00;
    else if (state == 2'b01 && w)
        state <= 2'b10;
    else if (state == 2'b10)
        state <= 2'b00;
    else if (state == 2'b00 && !w)
        state <= 2'b01;
    else if (state == 2'b11)
        state <= 2'b10;
    else if (state == 2'b01 && !w)
        state <= 2'b01;
    else if (state == 2'b10 && w)
        state <= 2'b11;
end
assign z = state[0];
endmodule

// VERILOG-EVAL: abnormal backticks count
