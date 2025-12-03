

module TopModule (
  input clk,
  input aresetn,
  input x,
  output reg z
);

always @(posedge clk) begin
    if (!aresetn) begin
        z <= 0;
    end else if (x == 1 && z == 0) begin
        z <= 1;
    end else if (x == 0 && z == 1) begin
        z <= 0;
    end else if (x == 1 && z == 1) begin
        z <= 1;
    end else if (x == 0 && z == 0) begin
        z <= 0;
    end
end

always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        z <= 0;
    end
end

// VERILOG-EVAL: endmodule not found
