
module TopModule (
  input clk,
  input in,
  input reset,
  output out
);

parameter [1:0] STATE_A = 2'b00;
parameter [1:0] STATE_B = 2'b01;
parameter [1:0] STATE_C = 2'b10;
parameter [1:0] STATE_D = 2'b11;

reg [1:0] current_state;
reg [1:0] next_state;

always @(posedge clk) begin
    if (reset)
        current_state <= STATE_A;
    else
        current_state <= next_state;
end

always @(*) begin
    case (current_state)
        STATE_A: begin
            if (in)
                next_state = STATE_B;
            else
                next_state = STATE_A;
        end
        STATE_B: begin
            if (in)
                next_state = STATE_B;
            else
                next_state = STATE_C;
        end
        STATE_C: begin
            if (in)
                next_state = STATE_D;
            else
                next_state = STATE_A;
        end
        STATE_D: begin
            if (in)
                next_state = STATE_B;
            else
                next_state = STATE_C;
        end
        default:
            next_state = STATE_A;
    endcase
end

assign out = (current_state == STATE_D);

endmodule
