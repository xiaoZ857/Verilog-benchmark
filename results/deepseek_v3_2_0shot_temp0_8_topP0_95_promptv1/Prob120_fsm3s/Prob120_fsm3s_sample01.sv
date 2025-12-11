
module TopModule (
  input clk,
  input in,
  input reset,
  output out
);
always @(posedge clk) begin
    if (reset) begin
        state <= 2'b00;
    end
    else begin
        case (state)
            2'b00: state <= (in) ? 2'b01 : 2'b00; // A -> B if in=1, else A
            2'b01: state <= (in) ? 2'b01 : 2'b10; // B -> B if in=1, else C
            2'b10: state <= (in) ? 2'b11 : 2'b00; // C -> D if in=1, else A
            2'b11: state <= (in) ? 2'b01 : 2'b10; // D -> B if in=1, else C
            default: state <= 2'b00;
        endcase
    end
end

assign out = (state == 2'b11); // Output is 1 only in state D
endmodule
