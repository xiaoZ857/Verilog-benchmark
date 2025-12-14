
module TopModule (
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);

    always @(posedge clk) begin
        if (load) begin
            // Load the initial configuration from the input 'data'
            q <= data;
        end else begin
            // Calculate each cell's next state based on Rule 110 using non-blocking assignments
            for (int i = 0; i < 512; i = i + 1) begin
                reg left, center, right;

                if (i == 0)
                    left = 0;
                else
                    left = q[i-1];
                    
                center = q[i];
                
                if (i == 511)
                    right = 0;
                else
                    right = q[i+1];

                // Apply Rule 110 to compute the next state of the cell, using non-blocking assignment
                casez ({left, center, right})
                    3'b111: q[i] <= 1'b0;
                    3'b110: q[i] <= 1'b0;
                    3'b101: q[i] <= 1'b1;
                    3'b100: q[i] <= 1'b0;
                    3'b011: q[i] <= 1'b1;
                    3'b010: q[i] <= 1'b1;
                    3'b001: q[i] <= 1'b1;
                    3'b000: q[i] <= 1'b0;
                endcase
            end
        end
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
