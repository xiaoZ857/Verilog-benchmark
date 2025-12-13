
module TopModule (
  input clk,
  input x,
  input [2:0] y,
  output reg Y0,
  output reg z
);

always @(posedge clk) begin
    // Logic for Y[0] based on state transition table
    case (y)
        3'b000: Y0 <= x ? 1'b1 : 1'b0;  // 000 -> 000 (x=0) or 001 (x=1)
        3'b001: Y0 <= x ? 1'b0 : 1'b1;  // 001 -> 001 (x=0) or 100 (x=1)
        3'b010: Y0 <= x ? 1'b1 : 1'b0;  // 010 -> 010 (x=0) or 001 (x=1)
        3'b011: Y0 <= x ? 1'b0 : 1'b1;  // 011 -> 001 (x=0) or 010 (x=1)
        3'b100: Y0 <= x ? 1'b0 : 1'b1;  // 100 -> 011 (x=0) or 100 (x=1)
        default: Y0 <= 1'b0;
    endcase
    
    // Logic for output z based on present state
    case (y)
        3'b000: z <= 1'b0;
        3'b001: z <= 1'b0;
        3'b010: z <= 1'b0;
        3'b011: z <= 1'b1;
        3'b100: z <= 1'b1;
        default: z <= 1'b0;
    endcase
end
endmodule
