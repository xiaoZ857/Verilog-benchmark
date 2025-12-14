
module TopModule (
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q
);

reg [63:0] q_reg;

always_comb begin
    case (amount)
        2'b00 : // left shift by 1 bit
            q_reg = q_reg << 1;
        2'b01 : // left shift by 8 bits
            q_reg = q_reg << 8;
        2'b10 : // right shift by 1 bit
            q_reg = {q_reg[31:0], 1'h0};
        2'b11 : // right shift by 8 bits
            q_reg = {q_reg[23:0], q_reg[15:8], 1'h0, q_reg[7:0]};
        default :
            q_reg = data;
    endcase
end

always @(posedge clk) begin
    if (ena && load == 1'b0) begin
        q_reg <= data;
    end else begin
        q_reg <= q_reg;
    end
end

assign q = q_reg;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
