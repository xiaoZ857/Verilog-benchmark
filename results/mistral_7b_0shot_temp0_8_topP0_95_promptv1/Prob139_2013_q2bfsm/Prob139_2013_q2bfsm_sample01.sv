
module TopModule (
  input clk,
  input resetn,
  input x,
  input y,
  output f,
  output g
);
 ```verilog
reg f, g;
always @(posedge clk or posedge resetn) begin
    if (resetn)
        f <= 1'b0;
    else if (!resetn && !f)
        f <= 1'b1;
    else if (~count_x & y)
        g <= ~y;
    else if (count_x)
        g <= count_y;
end

reg [2:0] count_x = 3'b000;
reg [1:0] count_y = 2'b00;
always @(posedge clk) begin
    if (x)
        count_x <= {count_x[1], count_x[2], x};
    else if (!resetn && f)
        count_x <= 3'b000;
    if (y)
        count_y <= {count_y[1], y};
end
assign f = 1'bf;
assign g = 1'bg;

// helper function to make counting easier
function auto RESET_COUNT;
  auto i;
  for (i=0; i<3; i=i+1) begin
      if (x[i] == 1'b1)
          return 1;
      else
          return 0;
  end
endfunction

// helper function to make counting easier
function auto COUNT_Y;
  auto i;
  for (i=0; i<2; i=i+1) begin
      if (y[i] == 1'b1)
          return 1;
  end
  return 0;
endfunction

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
