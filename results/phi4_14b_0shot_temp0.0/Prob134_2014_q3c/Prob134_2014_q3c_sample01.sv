

module TopModule (
  input clk,
  input x,
  input [2:0] y,
  output reg Y0,
  output reg z
);

always @(posedge clk) begin
    case (y)
        3'b000: Y0 <= (!x); // Next state is 001 when x=1, so Y0 = !x
        3'b001: Y0 <= y[0]; // Next state remains 001 regardless of x
        3'b010: Y0 <= y[0]; // Next state is 001 when x=1, so Y0 = y[0]
        3'b011: Y0 <= (!x); // Next state is 010 when x=0, so Y0 = !x
        3'b100: Y0 <= y[0]; // Next state remains 100 regardless of x
        default: Y0 <= 1'bx; // Undefined state
    endcase

    case (y)
        3'b011: z <= 1;
        3'b100: z <= 1;
        default: z <= 0;
    endcase
endmodule
