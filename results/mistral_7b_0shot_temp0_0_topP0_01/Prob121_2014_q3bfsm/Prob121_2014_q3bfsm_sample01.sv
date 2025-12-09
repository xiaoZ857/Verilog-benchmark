
module TopModule (
  input wire clk,
  input wire reset,
  input wire x,
  output reg [2:0] y,
  output reg z
);

always @(posedge clk or posedge reset) begin
  if (reset) begin
    y <= 3'b000; // Reset the FSM to state 000
    z <= 0;
  end else begin
    case (y)
      3'b000: begin
        if (x) y <= 3'b001;
        else y <= 3'b000;
        z <= 0;
      end
      3'b001: begin
        if (x) y <= 3'b100;
        else y <= 3'b001;
        z <= 0;
      end
      3'b010: begin
        y <= 3'b010;
        z <= 0;
      end
      3'b011: begin
        y <= 3'b001;
        z <= 1;
      end
      3'b100: begin
        y <= 3'b011;
        z <= 1;
      end
    endcase
  end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
