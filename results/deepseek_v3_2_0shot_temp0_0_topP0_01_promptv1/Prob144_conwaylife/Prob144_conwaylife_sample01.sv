
module TopModule (
  input clk,
  input load,
  input [255:0] data,
  output reg [255:0] q
);
always @(posedge clk) begin
    if (load) begin
        q <= data;
    end
    else begin
        for (int i = 0; i < 16; i = i + 1) begin
            for (int j = 0; j < 16; j = j + 1) begin
                // Calculate neighbor indices with wrap-around (toroidal grid)
                int up = (i == 0) ? 15 : i - 1;
                int down = (i == 15) ? 0 : i + 1;
                int left = (j == 0) ? 15 : j - 1;
                int right = (j == 15) ? 0 : j + 1;
                
                // Count live neighbors among the 8 neighbors
                int neighbor_count;
                neighbor_count = q[up*16 + left] + q[up*16 + j] + q[up*16 + right]
                               + q[i*16 + left] + q[i*16 + right]
                               + q[down*16 + left] + q[down*16 + j] + q[down*16 + right];
                
                // Apply Game of Life rules
                case (neighbor_count)
                    2: q[i*16 + j] <= q[i*16 + j]; // State unchanged
                    3: q[i*16 + j] <= 1'b1;        // Cell becomes alive
                    default: q[i*16 + j] <= 1'b0;  // Cases 0,1,4+ -> dead
                endcase
            end
        end
    end
end
endmodule
