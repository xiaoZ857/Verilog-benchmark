
module TopModule (
  input [1023:0] in,
  input [7:0] sel,
  output [3:0] out
);
always @(posedge clk) begin
    case(sel)
      0 : out <= in[3:0];
      1 : out <= in[7:4];
      2 : out <= in[11:8];
      // Add more cases for sel values 3 to 6 (for bits in[15:12], [19:16], ...)
      default : out <= 4'b0000; // Set output to zero if sel is not valid
    endcase
end

// Add clock enable and reset signals if needed
// e.g., always @(posedge clk or negedge reset) begin if (reset) out <= 4'b0000; end

endmodule
