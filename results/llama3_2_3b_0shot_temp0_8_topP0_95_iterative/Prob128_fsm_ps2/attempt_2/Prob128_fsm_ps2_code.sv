
module TopModule (
  input clk,
  input [7:0] in,
  input reset,
  output done
);
integer byte_count; // 0-2, 3 for valid message, -1 for invalid data

always @(posedge clk) begin
    if (reset) begin
        byte_count <= 0;
        done <= 0;
    end else begin
        if (byte_count < 0) byte_count <= -1;
        else if (byte_count < 2 && in[7] != 1) byte_count <= -1;
        else if (byte_count == 2 && in[3] == 1) byte_count <= 0;
        else if (byte_count == 2 && in[7] == 1) begin
            done <= 1;
            byte_count <= 3;
        end else if (byte_count < 3 && in[7] != 1) byte_count <= -1;
        else if (byte_count >= 0 && byte_count < 3) byte_count <= byte_count + 1;
    end
end

// Note: I removed done = 0 from the reset condition, since done should be active high synchronous,
// so it is better to simply not assign a value to it when reset is asserted.

// VERILOG-EVAL: endmodule not found
