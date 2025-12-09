

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

always @(posedge clk)
begin
    if (reset) 
        shift_ena <= 0;
    else
    begin
        if (~data[2] & ~data[1] & ~data[0] & data[3]) 
            shift_ena <= 1;
        else if (shift_ena == 1)
            shift_ena <= 0;
        else if (done_counting == 1 && counting == 0) 
            done <= 1;
        else if (ack == 1) 
            shift_ena <= 0;
    end
end

always @(posedge clk)
if (shift_ena == 1)
    counting <= counting + 1;

assign counting = counting & (~done_counting | ~done);

// VERILOG-EVAL: endmodule not found
