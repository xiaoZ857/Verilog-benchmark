
module TopModule (
  input clk,
  input areset,
  input x,
  output z
);
reg [1:0] state;
wire x, z;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 0;  // State A on reset
    end else begin
        case (state)
            0: begin  // State A
                if (x == 1) begin
                    state <= 1;  // Transition to B
                    z = 1;
                end else begin
                    state <= 0;  // Stay in A
                    z = 0;
                end
            end
            1: begin  // State B
                if (x == 1) begin
                    state <= 1;  // Remain in B
                    z = 0;
                end else begin
                    state <= 1;  // Remain in B
                    z = 1;
                end
            end
        endcase
    end
end

endmodule
