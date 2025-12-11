
module TopModule (
  input clock,
  input a,
  output reg p,
  output reg q
);
reg [1:0] state, next_state;

always @(posedge clock) begin
    if (state == 2'b00 && a == 1'b1)
        state <= 2'b01;
    else if (state == 2'b01 && a == 1'b0)
        state <= 2'b10;
    else if (state == 2'b10 && a == 1'b1)
        state <= 2'b11;
    else
        state <= 2'b00;
end

always @(*) begin
    case(state)
        2'b00: begin
            p = 1'b0; q = 1'b0;
        end
        2'b01: begin
            p = 1'b0; q = 1'b0;
        end
        2'b10: begin
            p = 1'b0; q = 1'b0;
        end
        2'b11: begin
            p = 1'b1; q = 1'b1;
        end
    endcase
end

endmodule
