
module TopModule (
  input clk,
  input a,
  output reg [2:0] q
);

always @(posedge clk) begin
    if (a == 1) begin
        case (q)
            4'd4: q <= 4'd5;
            4'd5: q <= 4'd6;
            4'd6: q <= 4'd0;
            default: q <= 4'd4;
        endcase
    end else begin
        case (q)
            4'd0: q <= 4'd1;
            4'd1: q <= 4'd1;
            default: q <= 4'd1;
        endcase
    end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
