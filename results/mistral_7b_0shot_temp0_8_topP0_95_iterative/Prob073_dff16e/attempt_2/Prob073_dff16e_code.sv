
module TopModule (
  input clk,
  input resetn,
  input [1:0] byteena,
  input [15:0] d,
  output reg [15:0] q
);
always @(posedge clk) begin
    if (!resetn) begin
        upper_d <= 8'b0; // Reset both upper and lower data registers
        lower_d <= 8'b0;
    end else begin
        if (byteena[1] && byteena[0]) begin // Both bytes enabled, write to outputs
            q <= upper_d[15:0];
        end else if (byteena[1]) begin // Only upper byte enabled, write to upper data register and output
            upper_d <= d[15:8];
            q <= upper_d[15:0];
        end else if (byteena[0]) begin // Only lower byte enabled, write to lower data register and output
            lower_d <= d[7:0];
            q <= lower_d[15:0];
        end
    end
end

// VERILOG-EVAL: endmodule not found
