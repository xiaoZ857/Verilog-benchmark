
module TopModule (
  input clk,
  input reset,
  input data,
  output start_shifting
);
reg [3:0] shift_reg;
reg start_shifting;

always @(posedge clk) begin
    if (reset) begin
        shift_reg <= 4'b0;
        start_shifting <= 1'b0;
    end else begin
        shift_reg <= {shift_reg[2:0], data};
        if (!start_shifting && shift_reg[2:0] == 3'b110 && data == 1'b1)
            start_shifting <= 1'b1;
    end
end

endmodule
