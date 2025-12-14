
module TopModule (
  input clk,
  input load,
  input [255:0] data,
  output reg [255:0] q
);
always @(posedge clk) begin
    if (load) begin
        q <= data; // Loading data into q at the next clock edge
    end else begin
        for (int i = 0; i < 256; i++) begin
            reg [7:0] num_neighbours; // Declare num_neighbours as reg in continuous assignment

            assign num_neighbours[0] = (i >= 15 && i <= 30) && (mod(i, 16) == 1); // Top-left neighbour
            assign num_neighbours[1] = (mod(i - 16, 256) == i || mod(i + 16, 256) == i) && (q[i] == 1); // Top and bottom wrapping neighbours
            assign num_neighbours[2] = (i >= 480 && i <= 504) || (mod(i - 16, 256) == i + 15 || mod(i + 16, 256) == i + 15) || (mod(i, 16) == 15); // Top-right neighbour
            assign num_neighbours[3] = (i >= 480 && i <= 504) && (q[(i - 16) % 256] == 1); // Right neighbour
            assign num_neighbours[4] = (i >= 464 && i <= 480) || (mod(i + 16, 256) == i); // Bottom-left neighbour
            assign num_neighbours[5] = q[(i + 16) % 256]; // Bottom neighbour
            assign num_neighbours[6] = (i >= 464 && i <= 480) || (mod(i - 16, 256) == i + 15); // Bottom-right neighbour
            assign num_neighbours[7] = (i > 15 && i < 30) && (q[(i - 16) % 256] == 1); // Left neighbour

            case (num_neighbours)
                0: q[i] <= 'b0; // Cell becomes 0
                1: q[i] <= q[i]; // Cell state does not change
                2: q[i] <= 'b1; // Cell becomes 1
                3: q[i] <= 'b0; // Cell becomes 0
                default: q[i] <= 'b0'; // Error handling, cell should not have more than 4 neighbors
            endcase
        end
    end
end
endmodule
