
module TopModule (
  input clk,
  input reset,
  input data,
  output reg shift_ena,
  output reg counting,
  input done_counting,
  output reg done,
  input ack
);
assign shift_ena = (data[3:2] == 2'b01) && (data[1] == 1'b0) && (data[0] == 1'b1);
assign counting = (done_counting == 1'b1) ? 1 : (shift_ena == 1'b1);

always @(posedge clk)
begin
    if (reset)
        shift_ena <= 1'b0;
        counting <= 1'b0;
    else if ((data[3:2] == 2'b01) && (data[1] == 1'b0) && (data[0] == 1'b1))
        shift_ena <= 1'b1;
    else
        shift_ena <= 1'b0;

    if (shift_ena)
        counting <= counting + 1;
    else if (done_counting == 1'b1)
        done <= 1'b1;
end

assign done = (counting >= 4) && (done_counting == 1'b1);

always @(posedge clk or reset)
begin
    if (reset)
        state <= 0;
    else if ((data[3:2] == 2'b01) && (data[1] == 1'b0) && (data[0] == 1'b1))
        state <= 1;
    else
        state <= 0;
end

assign ack = (state == 1);

reg [1:0] state;

always @(posedge clk)
begin
    if (done_counting == 1'b1 && done == 1'b0)
        state <= 2;
    else if (ack == 1'b0)
        state <= 3;
end

assign counting = (state == 2) ? 4 : (state == 3) ? 8 : (state == 0) ? 0 : counting;

// VERILOG-EVAL: endmodule not found
