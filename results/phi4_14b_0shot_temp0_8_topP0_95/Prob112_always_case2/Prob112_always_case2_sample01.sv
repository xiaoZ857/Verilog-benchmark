
module TopModule (
    input [3:0] in,
    output reg [1:0] pos
);

    // Combinational logic to determine the position of the first '1'
    always @(*) begin
        if (in[3]) begin
            pos = 2'b11;   // Position 4, since it's indexed from 0
        end else if (in[2]) begin
            pos = 2'b10;   // Position 3
        end else if (in[1]) begin
            pos = 2'b01;   // Position 2
        end else if (in[0]) begin
            pos = 2'b00;   // Position 1
        end else begin
            pos = 2'b00;   // If none of the bits are '1', output zero
        end
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
