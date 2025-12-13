
module TopModule (
  input clk,
  input a,
  output reg q
);

always @(posedge clk) begin
    case (a)
        0: 
            if (q == 1) q <= 1;
            else q <= 0;
        default:
            if (q == 1) q <= 1;
            else q <= 0;
    endcase
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
