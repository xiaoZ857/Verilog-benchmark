
module TopModule (
    input wire clk,
    input wire areset,
    input wire load,
    input wire ena,
    input wire [3:0] data,
    output reg [3:0] q
);

    // Asynchronous reset and synchronous load/shift operations
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset the shift register to zero on asynchronous reset
            q <= 4'b0000;
        end else begin
            if (load) begin
                // Load new data into the shift register
                q <= data;
            end else if (ena) begin
                // Shift right by one position with ena enabled
                q <= {1'b0, q[3:1]};  // q[0] is discarded
            end
        end
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
