
module TopModule (
  input clk,
  input reset,
  output reg [3:0] q
);
always @(posedge clk) begin
    if (reset) begin
        // Synchronous reset: Reset the counter to 1 when reset is high
        q <= 4'b0001;
    end else begin
        // Increment the counter, wrap around from 10 to 1
        case (q)
            4'b1010: q <= 4'b0001; // When count reaches 10, set it back to 1
            default : q <= q + 1;   // Otherwise, increment by 1
        endcase
    end
end

endmodule
