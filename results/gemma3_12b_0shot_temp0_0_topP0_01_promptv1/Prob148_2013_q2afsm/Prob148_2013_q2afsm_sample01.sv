
module TopModule (
  input clk,
  input resetn,
  input [3:1] r,
  output [3:1] g
);
logic [1:0] state;
logic next_state;
assign g[1] = (state == 2'b01);
assign g[2] = (state == 2'b10);
assign g[3] = (state == 2'b11);

always @(posedge clk) begin
  if (!resetn) begin
    state <= 2'b00;
  end else begin
    state <= next_state;
  end
end

always @(*) begin
  next_state = state;
  if (state == 2'b00) begin
    if (r[1]) begin
      next_state = 2'b01;
    end else if (r[2]) begin
      next_state = 2'b10;
    end else if (r[3]) begin
      next_state = 2'b11;
    end
  end else if (state == 2'b01) begin
    if (!r[1]) begin
      next_state = 2'b00;
    end
  end else if (state == 2'b10) begin
    if (!r[2]) begin
      next_state = 2'b00;
    end
  end else if (state == 2'b11) begin
    if (!r[3]) begin
      next_state = 2'b00;
    end
  end
end

assign g[1] = (state == 2'b01);
assign g[2] = (state == 2'b10);
assign g[3] = (state == 2'b11);
endmodule
