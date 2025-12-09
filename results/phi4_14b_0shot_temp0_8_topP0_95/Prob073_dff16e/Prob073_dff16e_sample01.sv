
module TopModule (
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output reg [15:0] q
);

    // Declare the internal registers
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            // Synchronous active-low reset, set all bits to 0
            q <= 16'b0000000000000000;
        end else begin
            // Check byteena and update the appropriate bytes in q
            if (byteena[1]) begin
                q[15:8] <= d[15:8]; // Update upper byte if enabled
            end
            if (byteena[0]) begin
                q[7:0]  <= d[7:0];  // Update lower byte if enabled
            end
        end
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
