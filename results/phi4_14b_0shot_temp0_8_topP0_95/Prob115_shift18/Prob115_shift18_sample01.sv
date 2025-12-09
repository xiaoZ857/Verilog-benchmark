
module TopModule (
    input wire clk,
    input wire load,
    input wire ena,
    input wire [1:0] amount,
    input wire [63:0] data,
    output reg [63:0] q
);

    always @(posedge clk) begin
        if (load) begin
            // Synchronous loading of the shift register with data[63:0]
            q <= data;
        end else if (ena) begin
            case (amount)
                2'b00: begin
                    // Shift left by 1 bit
                    q <= {q[62:0], 1'b0}; // Insert 0 on the rightmost position
                end
                2'b01: begin
                    // Shift left by 8 bits
                    q <= {q[55:0], 8'b00000000};
                end
                2'b10: begin
                    // Arithmetic shift right by 1 bit (sign extension)
                    q <= {q[63], q[62:0]};
                end
                2'b11: begin
                    // Arithmetic shift right by 8 bits (sign extension)
                    q <= {q[63], q[63:8]};
                end
            endcase
        end
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
