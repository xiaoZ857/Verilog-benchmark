
module TopModule (
  input clk,
  input load,
  input ena,
  input [1:0] amount,
  input [63:0] data,
  output reg [63:0] q
);
always @(posedge clk) begin
    if (load) begin
        // Load data into q when load is high
        q <= data;
    end else if (ena) begin
        case(amount)
            2'b00: begin
                // Arithmetic left shift by 1 bit
                q <= {q[62:0], 1'b0};
            end
            2'b01: begin
                // Arithmetic left shift by 8 bits
                q <= {q[55:0], 8'b0};
            end
            2'b10: begin
                // Arithmetic right shift by 1 bit
                q <= {q[63], q[62:0]};
            end
            2'b11: begin
                // Arithmetic right shift by 8 bits
                q <= {q[63], q[55:0]};
            end
        endcase
    end
end

endmodule
