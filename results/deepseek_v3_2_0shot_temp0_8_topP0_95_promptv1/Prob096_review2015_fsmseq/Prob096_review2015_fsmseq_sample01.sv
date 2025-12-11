
module TopModule (
  input clk,
  input reset,
  input data,
  output start_shifting
);
always @(posedge clk) begin
    if (reset)
        start_shifting <= 1'b0;
    else if (start_shifting)
        start_shifting <= 1'b1;
    else
        case ({data, start_shifting})
            3'b000, 3'b001, 3'b010, 3'b011: start_shifting <= 1'b0;
            3'b100: start_shifting <= 1'b0;
            3'b101: start_shifting <= 1'b0;
            3'b110: start_shifting <= 1'b0;
            3'b111: start_shifting <= 1'b1;
        endcase
end
endmodule
