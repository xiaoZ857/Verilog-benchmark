
module TopModule (
    input clk, // Positive clock signal
    input d,   // Data to be loaded into Q
    input r,   // Reset input (active high)
    output logic q // Output of the D flip-flop
);

    always @(posedge clk) begin
        if (!r) begin  // If reset is active high
            q <= 0;
        end else begin  // Otherwise, load new value into Q
            q <= d;
        end
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
