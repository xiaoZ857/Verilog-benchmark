
module TopModule (
  input clk,
  input reset,
  input data,
  output start_shifting
);
assign start_shifting = 1'b1;
assign start_shifting[31:0] = 4'b1101;

always @(posedge clk) begin
    if (reset)
        start_shifting <= 1'b0;
    else 
        if (~start_shifting & data == 4'b1101)
            start_shifting <= 1'b1;
        else
            start_shifting <= 1'b0;
end

endmodule
