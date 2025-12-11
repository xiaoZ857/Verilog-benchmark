
module TopModule (
  input clk,
  input load,
  input ena,
  input [1:0] amount,
  input [63:0] data,
  output reg [63:0] q
);
 ```verilog
always @(posedge clk) begin
    if (load)
        q <= data;
    else if (ena) begin
        case (amount)
            2'b00 : q <= {q[1], q[63-1:1]};
            2'b01 : q <= {q[64], q[63-7:1]};
            2'b10 : q <= {q[62], q[0]};
            2'b11 : q <= {q[63-8], q[0]};
        endcase
    end
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
