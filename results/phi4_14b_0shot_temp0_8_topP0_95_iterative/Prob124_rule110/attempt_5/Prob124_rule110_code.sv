
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
        reg [511:0] next_q;  // Temporary register to hold the next state of each cell

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

            // Apply Rule 110 to compute the next state of the cell, storing it in `next_q`
            casez ({left, center, right})
                3'b111: next_q[i] = 1'b0;
                3'b110: next_q[i] = 1'b0;
                3'b101: next_q[i] = 1'b1;
                3'b100: next_q[i] = 1'b0;
                3'b011: next_q[i] = 1'b1;
                3'b010: next_q[i] = 1'b1;
                3'b001: next_q[i] = 1'b1;
                3'b000: next_q[i] = 1'b0;
            endcase
        end

        // After calculating the entire new state, assign it to `q`
        q <= next_q;
    end
end

endmodule
