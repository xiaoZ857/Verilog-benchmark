
module TopModule (
  input [6:1] y,
  input w,
  output Y2,
  output Y4
);
 ```verilog
always @(posedge clk) begin
    if (y[6]) // A
        Y2 <= w;
    else if (y[5]) // B
        Y2 <= ~w;
    else if (y[3]) // D
        Y2 <= w;
    else if (y[4]) // C or F
        Y2 <= ~w;
    else // E
        Y2 <= Y2; // no change
end

always @(posedge clk) begin
    if (y[6]) // A
        Y4 <= w;
    else if (y[5]) // B
        Y4 <= ~w;
    else if (y[1]) // A or F
        Y4 <= w;
    else if (y[4]) // C or D
        Y4 <= ~w;
    else // E
        Y4 <= Y4; // no change
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
