
module TopModule (
  input clk,
  input shift_ena,
  input count_ena,
  input data,
  output reg [3:0] q
);

always @(posedge clk) begin
    if (shift_ena) begin
        q <= {data, q[2], q[1], q[0]};  // Shift in data as MSB and shift right others
    else if (count_ena) begin
        if (q > 0) begin
            q <= q - 1;  // Decrement counter
        end
        // No action if q is 0 to prevent underflow
    end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
