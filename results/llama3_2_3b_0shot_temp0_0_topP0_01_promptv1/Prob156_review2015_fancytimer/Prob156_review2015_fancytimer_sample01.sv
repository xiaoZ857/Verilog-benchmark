
module TopModule (
  input wire clk,
  input wire reset,
  input wire data,
  output wire [3:0] count,
  output reg counting,
  output reg done,
  input wire ack
);
assign out = (data[2:1] == 2'b01) && (data[0] == 1'b1);
assign counting = (out == 4'b1101);
assign done = ~counting;

always @(posedge clk)
begin
    if (reset)
        count <= 4'b0000;
    else if (out == 4'b1101)
        count <= {delay[3:0], count};
    else if (count > delay[3:0] * 1000)
        count <= count - 1;
    else
        count <= 4'b0000;
end

assign ack = done;

always @(posedge clk)
begin
    if (reset || out == 4'b1101)
        counting <= 1'b0;
    else if (count > delay[3:0] * 1000)
        counting <= 1'b1;
    else
        counting <= 1'b0;
end

assign count[3:0] = out;

always @(posedge clk)
begin
    if (reset || out == 4'b1101)
        done <= 1'b0;
    else if (count > delay[3:0] * 1000)
        done <= 1'b1;
    else
        done <= 1'b0;
end

assign data = counting ? {ack, count[2:0], count[1]} : 4'b0000;

always @(posedge clk)
begin
    if (reset || out == 4'b1101)
        delay <= 4'b0000;
    else
        delay <= {delay[3:0] + 1, delay[3:0]};
end

// VERILOG-EVAL: endmodule not found
