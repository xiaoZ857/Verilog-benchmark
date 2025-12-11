
module TopModule (
  input clk,
  input reset,
  input x,
  output reg z
);
always @(posedge clk) begin
    if (reset) begin
        z <= 1'b0;
    end else begin
        case (y)
            3'b000: begin
                if (x) begin
                    y <= 3'b001;
                end else begin
                    y <= 3'b000;
                end
                z <= 1'b0;
            end
            3'b001: begin
                if (x) begin
                    y <= 3'b100;
                end else begin
                    y <= 3'b001;
                end
                z <= 1'b0;
            end
            3'b010: begin
                if (x) begin
                    y <= 3'b001;
                end else begin
                    y <= 3'b010;
                end
                z <= 1'b0;
            end
            3'b011: begin
                if (x) begin
                    y <= 3'b010;
                end else begin
                    y <= 3'b001;
                end
                z <= 1'b1;
            end
            3'b100: begin
                if (x) begin
                    y <= 3'b100;
                end else begin
                    y <= 3'b011;
                end
                z <= 1'b1;
            end
            default: begin
                y <= 3'b000;
                z <= 1'b0;
            end
        endcase
    end
end

endmodule
