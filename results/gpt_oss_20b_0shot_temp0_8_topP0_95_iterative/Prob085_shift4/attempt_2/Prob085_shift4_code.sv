
module TopModule (
  input clk,
  input areset,
  input load,
  input ena,
  input [3:0] data,
  output reg [3:0] q
);
    // Synchronous logic with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            q <= 4'b0000;          // reset to zero
        end
        else if (load) begin
            q <= data;             // load data (higher priority)
        end
        else if (ena) begin
            q <= {1'b0, q[3:1]};   // shift right by one
        end
    end
endmodule
