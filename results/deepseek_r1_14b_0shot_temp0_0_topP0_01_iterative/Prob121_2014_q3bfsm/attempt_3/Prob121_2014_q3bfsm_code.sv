
module TopModule (
  input clk,
  input reset,
  input x,
  output reg z
);
always @(posedge clk) begin
    if (reset) begin
        y <= S000;
    end else begin
        case (y)
            S000:
                if (x == 0) begin
                    y <= S000;
                    z <= 0;
                end else begin
                    y <= S001;
                    z <= 0;
                end
            S001:
                if (x == 0) begin
                    y <= S001;
                    z <= 0;
                end else begin
                    y <= S100;
                    z <= 0;
                end
            S010:
                if (x == 0) begin
                    y <= S010;
                    z <= 0;
                end else begin
                    y <= S001;
                    z <= 0;
                end
            S011:
                if (x == 0) begin
                    y <= S001;
                    z <= 1;
                end else begin
                    y <= S010;
                    z <= 1;
                end
            S100:
                if (x == 0) begin
                    y <= S011;
                    z <= 1;
                end else begin
                    y <= S100;
                    z <= 1;
                end
        endcase
    end
end

endmodule
