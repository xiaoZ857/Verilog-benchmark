

module TopModule (
  input clk,
  input reset,
  output reg [3:0] q
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        q <= 4'b0001; // Reset to 1
    end else begin
        case (q)
            4'b0001: q <= 4'b0010;
            4'b0010: q <= 4'b0011;
            4'b0011: q <= 4'b0100;
            4'b0100: q <= 4'b0101;
            4'b0101: q <= 4'b0110;
            4'b0110: q <= 4'b0111;
            4'b0111: q <= 4'b1000;
            4'b1000: q <= 4'b1001;
            4'b1001: q <= 4'b0001; // Wrap around to 1
            default: q <= 4'b0001; // Default case for safety
        endcase
    end
end

endmodule
