
module TopModule (
  input clk,
  input load,
  input ena,
  input [1:0] amount,
  input [63:0] data,
  output reg [63:0] q
);
reg [63:0] q_reg;

always @(posedge clk) begin
    if (load) begin
        // Load the shift register with new data
        q_reg <= data;
    end else if (ena && amount == 2'b00) begin
        // Shift left by 1 bit
        q_reg <= {q_reg[62:0], 1'b0};
    end else if (ena && amount == 2'b01) begin
        // Shift left by 8 bits
        q_reg <= {q_reg[55:48], q_reg[47:40], q_reg[39:32], q_reg[31:24], q_reg[23:16], q_reg[15:8], q_reg[7:0]};
    end else if (ena && amount == 2'b10) begin
        // Shift right by 1 bit
        q_reg <= {q_reg[62:1], q_reg[0]};
    end else if (ena && amount == 2'b11) begin
        // Shift right by 8 bits
        q_reg <= {q_reg[55:46], q_reg[47:38], q_reg[39:30], q_reg[31:22], q_reg[23:14], q_reg[15:6], q_reg[7:0]};
    end
end

assign q = q_reg;

endmodule
