
module TopModule (
  input clk,
  input in,
  input reset,
  output out
);
reg [1:0] state, next_state;

always @(*) begin
    case (state)
        2'b00: next_state = in ? 2'b01 : 2'b00; // A
        2'b01: next_state = in ? 2'b01 : 2'b10; // B
        2'b10: next_state = in ? 2'b11 : 2'b00; // C
        2'b11: next_state = in ? 2'b01 : 2'b10; // D
        default: next_state = 2'b00;
    endcase
end

always @(posedge clk) begin
    if (reset)
        state <= 2'b00;
    else
        state <= next_state;
end

assign out = (state == 2'b11);

endmodule
