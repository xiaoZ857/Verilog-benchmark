
module TopModule (
  input [4:1] x,
  output logic f
);
assign x_2 = x[2];
assign x_3 = x[3];

always @(x_2 or x_3) begin
    if (x_2 == 0 && x_3 == 0) begin
        f <= d;
    end
    else if (x_2 == 1 && x_3 == 1) begin
        f <= d;
    end
    else if (x_2 == 1 && x_3 == 0 || x_2 == 0 && x_3 == 1) begin
        f <= 0;
    end
end

assign d = 1'b1;

// VERILOG-EVAL: endmodule not found
