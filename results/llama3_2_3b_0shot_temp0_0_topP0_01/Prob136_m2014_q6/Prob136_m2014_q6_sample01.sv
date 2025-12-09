

module TopModule (
  input clk,
  input reset,
  input w,
  output z
);

always @(posedge clk)
begin
    if (reset) begin
        z <= 1;
    end else if (w == 0 && z == 1) begin
        z <= 0;
    end else if (z == 1) begin
        z <= w;
    end else if (w == 0) begin
        z <= 1;
    end else if (z == 0) begin
        z <= w;
    end else if (w == 1) begin
        z <= 0;
    end else if (z == 1 && w == 1) begin
        z <= 0;
    end else if (z == 0 && w == 1) begin
        z <= 1;
    end
end

always @(posedge clk)
begin
    if (reset) begin
        z <= 1;
    end else if (w == 0 && z == 1) begin
        z <= 0;
    end else if (z == 1) begin
        z <= w;
    end else if (w == 0) begin
        z <= 1;
    end else if (z == 0) begin
        z <= w;
    end else if (w == 1) begin
        z <= 0;
    end else if (z == 1 && w == 1) begin
        z <= 0;
    end else if (z == 0 && w == 1) begin
        z <= 1;
    end
end

always @(posedge clk)
begin
    if (reset) begin
        z <= 1;
    end else if (w == 0 && z == 1) begin
        z <= 0;
    end else if (z == 1) begin
        z <= w;
    end else if (w == 0) begin
        z <= 1;
    end else if (z == 0) begin
        z <= w;
    end else if (w == 1) begin
        z <= 0;
    end else if (z == 1 && w == 1) begin
        z <= 0;
    end else if (z == 0 && w == 1) begin
        z <= 1;
    end
end

always @(posedge clk)
begin
    if (reset) begin
        z <= 1;
    end else if (w == 0 && z == 1) begin
        z <= 0;
    end else if (z == 1) begin
        z <= w;
    end else if (w == 0) begin
        z <= 1;
    end else if (z == 0) begin
        z <= w;
    end else if (w == 1) begin
        z <= 0;
    end else if (z == 1 && w == 1) begin
        z <= 0;
    end else if (z == 0 && w == 1) begin
        z <= 1;
    end
end

always @(posedge clk)
begin
    if (reset) begin
        z <= 1;
    end else if (w == 0 && z == 1) begin
        z <= 0;
    end else if (z == 1) begin
        z <= w;
    end else if (w == 0) begin
        z <= 1;
    end else if (z == 0) begin
        z <= w;
    end else if (w == 1) begin
        z <= 0;
    end else if (z == 1 && w == 1) begin
        z <= 0;
    end else if (z == 0 && w == 1) begin
        z <= 1;
    end
end

always @(posedge clk)
begin
    if (reset) begin
        z <= 1;
    end else if (w == 0 && z == 1) begin
        z <= 0;
    end else if (z == 1) begin
        z <= w;
    end else if (w == 0) begin
        z <= 1;
    end else if (z == 0) begin
        z <= w;
    end else if (w == 1) begin
        z <= 0;
    end else if (z == 1 && w == 1) begin
        z <= 0;
    end else if (z == 0 && w == 1) begin
        z <= 1;
    end
end

always @(posedge clk)
begin
    if (reset) begin
        z <= 1;
    end else if (w == 0

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
