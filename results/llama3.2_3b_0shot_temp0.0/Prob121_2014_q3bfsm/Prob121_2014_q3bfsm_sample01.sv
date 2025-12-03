

module TopModule (
  input clk,
  input reset,
  input x,
  output reg z
);

always @(*) begin
    case(zend)
        0: begin
            if(x == 0) begin
                z <= 0;
            end else begin
                z <= 1;
            end
        end
        1: begin
            if(x == 0) begin
                z <= 0;
            end else begin
                z <= 1;
            end
        end
    endcase
end

always @(posedge clk) begin
    if(reset) begin
        z <= 0;
    end
end

// VERILOG-EVAL: endmodule not found
