
module TopModule (
  input clk,
  input [7:0] in,
  input reset,
  output [23:0] out_bytes,
  output done
);
always @(posedge clk) begin
    if (reset) begin
        state <= 2'b00;
        b1 <= 8'b0;
        b2 <= 8'b0;
        b3 <= 8'b0;
    end else begin
        state <= next_state;
        case (state)
            2'b00: if (in[3]) b1 <= in;
            2'b01: b2 <= in;
            2'b10: b3 <= in;
            2'b11: if (in[3]) b1 <= in;
        endcase
    end
end

always @(*) begin
    case (state)
        2'b00: next_state = in[3] ? 2'b01 : 2'b00;
        2'b01: next_state = 2'b10;
        2'b10: next_state = 2'b11;
        2'b11: next_state = in[3] ? 2'b01 : 2'b00;
        default: next_state = 2'b00;
    endcase
end

assign done = (state == 2'b11);
assign out_bytes = {b1, b2, b3};

reg [1:0] state, next_state;
reg [7:0] b1, b2, b3;

endmodule
