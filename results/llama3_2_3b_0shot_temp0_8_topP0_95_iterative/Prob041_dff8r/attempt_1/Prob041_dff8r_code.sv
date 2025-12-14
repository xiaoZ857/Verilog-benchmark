
module TopModule (
    input clk, // Positive edge clock signal
    input [7:0] d, // Data to be written into DFFs
    input reset, // Synchronous reset signal
    output reg [7:0] q // Output of all DFFs
);

    always @(posedge clk) begin // Trigger DFFs on the rising edge of the clock
        if (reset == 1'b1) begin // Reset condition met when synchronous reset is high
            q <= 8'h000; // Set output to zero in case of synchronous reset
        } else begin // Writing data into DFFs
            q <= d; // Assign input data to the output
        end
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
