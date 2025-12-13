
module TopModule (
  input clk,
  input d,
  input ar,
  output logic q
);

always @ (posedge clk) begin
    if (ar) begin
        q <= 0;
    end else begin
        q <= d;
    end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
