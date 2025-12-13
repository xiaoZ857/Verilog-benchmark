
module TopModule (
  input clk,
  input areset,
  input x,
  output z
);
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 1'b0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        1'b0: begin
            z = x;
            next_state = x ? 1'b1 : 1'b0;
        end
        1'b1: begin
            z = ~x;
            next_state = 1'b1;
        end
        default: begin
            z = x;
            next_state = 1'b0;
        end
    endcase
end

endmodule
