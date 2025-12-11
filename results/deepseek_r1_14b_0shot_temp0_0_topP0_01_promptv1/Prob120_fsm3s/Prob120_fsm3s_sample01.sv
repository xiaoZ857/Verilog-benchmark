
module TopModule (
  input clk,
  input in,
  input reset,
  output out
);
always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 2'b00; // State A
    else begin
        case (state)
            2'b00: // State A
                if (~in) state <= 2'b00; // stay in A when in=0
                else     state <= 2'b01; // go to B when in=1
            2'b01: // State B
                if (~in) state <= 2'b10; // go to C when in=0
                else     state <= 2'b01; // stay in B when in=1
            2'b10: // State C
                if (~in) state <= 2'b00; // go to A when in=0
                else     state <= 2'b11; // go to D when in=1
            2'b11: // State D
                if (~in) state <= 2'b10; // go to C when in=0
                else     state <= 2'b01; // go to B when in=1
        endcase
    end
end

always @(state or in) begin
    case (state)
        2'b00: out = 1'b0; // State A
        2'b01: out = 1'b0; // State B
        2'b10: out = 1'b0; // State C
        2'b11: out = 1'b1; // State D
    endcase
end

endmodule
