
module TopModule (
  input [4:1] x,
  output logic f
);
always @(x[2] or x[3]) begin
    if (x[2] == 1 && x[3] == 1) begin
        f <= 1;
    end
    else if ((x_2 == 0 || x_3 == 0)) begin
        f <= d;
    end
end

always @(x_2 or x_3) begin
    if (x_2 == 1 && x_3 == 1) begin
        f <= 1;
    end
end

assign f = ~d; // since the rest of the conditions are covered by either d or x[2]/x[3] being true

// VERILOG-EVAL: endmodule not found
