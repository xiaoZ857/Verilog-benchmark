
module TopModule (
  input wire clk,
  input wire reset,
  input wire data,
  output wire [3:0] count,
  output reg counting,
  output reg done,
  input wire ack
);
 ```verilog
always @(posedge clk or negedge reset) begin
    if (reset)
        counting <= 0;
    else if (!counting && data == 1101) begin
        count = {data[3], data[2], data[1], data[0]};
        counting <= 1;
    end
    else if (counting) begin
        always_comb begin
            reg remaining = count + 4'b0001 - count;
            counting <= (remaining > 0);
            count <= remaining - 1;
        end
    end
    done <= (counting && (count == 0));
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
