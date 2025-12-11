
module TopModule (
  input clk,
  input areset,
  input x,
  output z
);
 ```verilog
reg [1:0] state;
always @(posedge clk or negedge areset) begin
    if (areset)
        state <= 2'b00;
    else if (state == 2'b01 && x == 1'b1)
        state <= 2'b10;
    else if (state == 2'b10 && x == 1'b0)
        state <= 2'b10;
    else if (state == 2'b10 && x == 1'b1)
        state <= 2'b01;
end

assign z = state[0];
endmodule

// VERILOG-EVAL: abnormal backticks count
