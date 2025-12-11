
module TopModule (
  input clk,
  input in,
  input reset,
  output done
);
assign done = (in[7:0] & in[15:8]) & (in[0] == 1) & (in[16] == 1);

always @(*) begin
    if (reset)
        done = 1'b0;
    else if ((~in[15:8]) | (~in[7:0])) 
        done <= 1'b0;
    else if(~in[0])
        done <= 1'b0;
    else if(in[16] == 1)
        done <= 1'b1;
end

// VERILOG-EVAL: endmodule not found
