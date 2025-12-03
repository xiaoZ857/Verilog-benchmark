

module TopModule (
  input clk,
  input reset,
  input x,
  output reg z
);

reg [2:0] y;

always @(posedge clk or posedge reset) begin
    if (reset)
        y <= 3'b000;
    else
        case (y)
            3'b000: y <= x ? 3'b001 : 3'b000;
            3'b001: y <= x ? 3'b100 : 3'b001;
            3'b010: y <= x ? 3'b001 : 3'b010;
            3'b011: y <= x ? 3'b010 : 3'b001;
            3'b100: y <= x ? 3'b100 : 3'b011;
            default: y <= 3'b000; // Default case to handle unexpected states
        endcase
end

always @(posedge clk) begin
    if (y == 3'b011 || y == 3'b100)
        z <= 1'b1;
    else
        z <= 1'b0;
end

endmodule
