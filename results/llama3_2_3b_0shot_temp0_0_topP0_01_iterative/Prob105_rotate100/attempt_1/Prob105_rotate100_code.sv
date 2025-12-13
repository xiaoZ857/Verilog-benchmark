
module TopModule(
    input clk, // Positive clock/clk triggered
    input load, // Synchronous active high
    input [1:0] ena, // Synchronous
    input [99:0] data, // 100-bit left/right rotator
    output reg [99:0] q // The contents of the rotator
);

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else if (ena == 2'b01) begin // Rotate right by one bit
            q <= {data[99], data[98:0]};
        end else if (ena == 2'b10) begin // Rotate left by one bit
            q <= {data[1:0], data[99:98]};
        end else begin // Do not rotate
            q <= data;
        end
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
