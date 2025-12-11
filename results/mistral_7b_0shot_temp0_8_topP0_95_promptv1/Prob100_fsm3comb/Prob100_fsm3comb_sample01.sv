
module TopModule (
  input in,
  input [1:0] state,
  output reg [1:0] next_state,
  output out
);
always @(posedge clk) begin
    case (state)
        2'b00 : begin
            if (in === 0)
                next_state <= 2'b00;
            else
                next_state <= 2'b01;
            out <= 0;
        end
        2'b01 : begin
            if (in === 0)
                next_state <= 2'b10;
            else
                next_state <= 2'b01;
            out <= 0;
        end
        2'b10 : begin
            if (in === 0)
                next_state <= 2'b00;
            else
                next_state <= 2'b11;
            out <= 0;
        end
        2'b11 : begin
            if (in === 0)
                next_state <= 2'b10;
            else
                next_state <= 2'b01;
            out <= 1;
        enddefault: next_state <= 2'bX; // handle illegal states
    endcase
end

// VERILOG-EVAL: endmodule not found
