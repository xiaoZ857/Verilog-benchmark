
module TopModule (
  input d,
  input ena,
  input clk,
  output logic q
);

always @ (posedge clk or negedge ena) begin
    if (!ena) begin
        q <= 0;
    end else begin
        q <= d;
    end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
