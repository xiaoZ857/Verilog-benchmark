
module TopModule (
  input clk,
  input j,
  input k,
  input areset,
  output out
);
logic current_state;

always @(posedge clk or posedge areset) begin
  if (areset) begin
    current_state <= 1'b0;
  end else begin
    case (current_state)
      1'b0: begin
        if (j)
          current_state <= 1'b1;
        else
          current_state <= 1'b0;
      end
      1'b1: begin
        if (k)
          current_state <= 1'b0;
        else
          current_state <= 1'b1;
      end
    endcase
  end
end

assign out = current_state;
endmodule
