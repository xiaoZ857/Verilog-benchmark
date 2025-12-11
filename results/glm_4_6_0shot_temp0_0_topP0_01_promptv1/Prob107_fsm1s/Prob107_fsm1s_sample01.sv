
module TopModule (
  input clk,
  input in,
  input reset,
  output out
);

parameter A = 1'b0, B = 1'b1;
reg state;

always @(posedge clk) begin
    if (reset) begin
        state <= B;
    end else begin
        case (state)
            B: begin
                if (in == 0)
                    state <= A;
                else
                    state <= B;
            end
            A: begin
                if (in == 0)
                    state <= B;
                else
                    state <= A;
            end
        endcase
    end
end

assign out = (state == B);
endmodule
