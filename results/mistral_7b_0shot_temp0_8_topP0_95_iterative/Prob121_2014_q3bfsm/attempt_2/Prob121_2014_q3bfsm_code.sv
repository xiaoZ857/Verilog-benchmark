
module TopModule (
  input clk,
  input reset,
  input x,
  output reg z
);
always @(posedge clk or posedge reset) begin
  if (reset) begin
    y <= 3'b0; // Reset to state 000
    z <= 0;
  end else begin
    case (y)
      3'b000 : begin
          if (x) y <= 3'b001;
          else y <= 3'b000;
          z <= 0;
        end,
      3'b001 : begin
          if (x) y <= 3'b100;
          else y <= 3'b001;
          z <= 0;
        end,
      3'b010 : begin
          if (x) y <= 3'b001;
          else y <= 3'b010;
          z <= 0;
        end,
      3'b011 : begin
          if (x) y <= 3'b010;
          else y <= 3'b011;
          z <= 1;
        end,
      3'b100 : begin
          if (x) y <= 3'b100;
          else y <= 3'b011;
          z <= 1;
        end
    endcase
  end
end

// Include this line at the bottom of your file to make the testbench function work correctly
initial begin
  #5 reset = 1;
  #10 reset = 0;
end

// VERILOG-EVAL: endmodule not found
