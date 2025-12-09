

module TopModule (
  input [15:0] scancode,
  output reg left,
  output reg down,
  output reg right,
  output reg up
);

always @(posedge clk) begin
  case (scancode)
    16'he06b: left <= 1; down <= 0; right <= 0; up <= 0;
    16'he072: left <= 0; down <= 1; right <= 0; up <= 0;
    16'he074: left <= 0; down <= 0; right <= 1; up <= 0;
    16'he075: left <= 0; down <= 0; right <= 0; up <= 1;
    default:   left <= 0; down <= 0; right <= 0; up <= 0;
  endcase
end

// VERILOG-EVAL: endmodule not found
