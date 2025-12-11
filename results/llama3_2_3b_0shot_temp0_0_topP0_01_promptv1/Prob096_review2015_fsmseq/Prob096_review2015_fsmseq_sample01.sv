
module TopModule (
  input clk,
  input reset,
  input data,
  output start_shifting
);
assign start_shifting = 1'b1;

always @(posedge clk) begin
    if (reset)
        start_shifting <= 1'b0;
    else if (data[2] & data[1] & ~data[0] & ~data[3])
        start_shifting <= 1'b1;
end

assign data[2] = data[1];
assign data[1] = data[0];
assign data[0] = ~data[3];

always @(posedge clk) begin
    if (start_shifting == 1'b1)
        data[2] <= data[1];
    else
        data[2] <= 1'b0;
end

assign data[1] = data[0];
assign data[0] = ~data[3];

always @(posedge clk) begin
    if (start_shifting == 1'b1)
        data[1] <= data[0];
    else
        data[1] <= 1'b0;
end

assign data[0] = ~data[3];

// VERILOG-EVAL: endmodule not found
