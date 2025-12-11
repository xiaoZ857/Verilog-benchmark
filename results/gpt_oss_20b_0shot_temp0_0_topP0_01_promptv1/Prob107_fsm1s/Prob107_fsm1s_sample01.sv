
module TopModule (
  input clk,
  input in,
  input reset,
  output out
);
reg state;
localparam B = 1'b0;
localparam A = 1'b1;

assign out = (state == B);

always @(posedge clk) begin
    if (reset)
        state <= B;
    else
        case (state)
            B: if (in == 0) state <= A; else state <= B;
            A: if (in == 0) state <= B; else state <= A;
        endcase
end

endmodule
