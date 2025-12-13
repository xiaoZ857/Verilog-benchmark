
module TopModule (
  input [15:0] scancode,
  output reg left,
  output reg down,
  output reg right,
  output reg up
);

reg clock;

always @(posedge clock) begin
    case (scancode)
        16'hE06B: left = 1; down = 0; right = 0; up = 0;
        16'hE072: left = 0; down = 1; right = 0; up = 0;
        16'hE074: left = 0; down = 0; right = 1; up = 0;
        16'hE075: left = 0; down = 0; right = 0; up = 1;
        default:   left = 0; down = 0; right = 0; up = 0;
    endcase
end

initial begin
    left = 0;
    down = 0;
    right = 0;
    up = 0;
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
