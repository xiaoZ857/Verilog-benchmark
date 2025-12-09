

module TopModule (
  input clk,
  input x,
  input [2:0] y,
  output reg Y0,
  output reg z
);

always @(posedge clk) begin
    case (y)
        3'b000 : begin
            if (x === 0)
                Y = 3'b000;
            else
                Y = 3'b001;
            z <= 0;
        end
        3'b001 : begin
            if (x === 0)
                Y = 3'b001;
            else
                Y = 4'b100;
            z <= 0;
        end
        3'b010 : begin
            Y = 3'b010;
            z <= 0;
        end
        3'b011 : begin
            Y = 3'b001;
            z <= 1;
        end
        3'b100 : begin
            Y = 4'b011;
            z <= 1;
        end
    endcase
end

assign Y0 = Y[0];

endmodule
