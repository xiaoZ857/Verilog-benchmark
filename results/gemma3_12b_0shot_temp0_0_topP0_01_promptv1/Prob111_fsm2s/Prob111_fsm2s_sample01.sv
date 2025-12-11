
module TopModule (
  input clk,
  input j,
  input k,
  input reset,
  output out
);
logic current_state;
logic next_state;

always @(posedge clk) begin
  if (reset) begin
    current_state <= 0;
  else begin
    current_state <= next_state;
  end
end

always @(*) begin
  next_state = current_state;
  if (current_state == 0) begin
    if (j == 0) begin
      next_state = 0;
    end else begin
      next_state = 1;
    end
  end else begin
    if (k == 0) begin
      next_state = 1;
    end else begin
      next_state = 0;
    end
  end
end

assign out = current_state;
endmodule
