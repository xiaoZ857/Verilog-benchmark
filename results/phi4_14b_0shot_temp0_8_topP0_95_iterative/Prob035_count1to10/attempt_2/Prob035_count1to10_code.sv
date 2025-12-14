
module TopModule (
  input clk,
  input reset,
  output reg [3:0] q
);
always @(posedge clk or posedge reset) begin
    if (reset) begin
        // Reset is active high synchronous, set counter to 1
        q <= 4'b0001;
    end else begin
        // Implement counting logic for 1 through 10, wrapping around correctly
        case (q)
            4'b1010: begin
                // If current value is 10, wrap around to 1
                q <= 4'b0001;
            end
            default: begin
                // For all other values, increment the counter
                q <= q + 1;
            end
        endcase
    end
end

endmodule
