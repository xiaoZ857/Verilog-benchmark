
module TopModule (
  input clk,
  input areset,
  input load,
  input ena,
  input [3:0] data,
  output reg [3:0] q
);
assign q = {data[3], data[2], data[1], load ? data[0] : 4'b0};

always @(posedge clk or areset) begin
   if (!areset)
       q <= 4'b0;
   else
       if (ena == 1'b1)
           q <= data;
       else
           assign q = {data[3], data[2], data[1], load ? data[0] : 4'b0};
end

// VERILOG-EVAL: endmodule not found
