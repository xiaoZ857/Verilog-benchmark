
module TopModule (
  input clk,
  input load,
  input [255:0] data,
  output reg [255:0] q
);
    wire [255:0] next_q;
    genvar i, j;
    generate
        for (i = 0; i < 16; i = i + 1) begin : row
            for (j = 0; j < 16; j = j + 1) begin : col
                // Compute neighbor indices with wrap-around
                localparam UP = (i == 0) ? 15 : i - 1;
                localparam DOWN = (i == 15) ? 0 : i + 1;
                localparam LEFT = (j == 0) ? 15 : j - 1;
                localparam RIGHT = (j == 15) ? 0 : j + 1;
                
                // Get neighbor cell values
                wire nw, n, ne, w, e, sw, s, se;
                
                // NW: (UP, LEFT)
                assign nw = q[UP*16 + LEFT];
                // N: (UP, j)
                assign n  = q[UP*16 + j];
                // NE: (UP, RIGHT)
                assign ne = q[UP*16 + RIGHT];
                // W: (i, LEFT)
                assign w  = q[i*16 + LEFT];
                // E: (i, RIGHT)
                assign e  = q[i*16 + RIGHT];
                // SW: (DOWN, LEFT)
                assign sw = q[DOWN*16 + LEFT];
                // S: (DOWN, j)
                assign s  = q[DOWN*16 + j];
                // SE: (DOWN, RIGHT)
                assign se = q[DOWN*16 + RIGHT];
                
                // Sum of neighbors
                wire [3:0] neighbor_sum;
                assign neighbor_sum = nw + n + ne + w + e + sw + s + se;
                
                // Next state logic
                reg next_state;
                always @(*) begin
                    case (neighbor_sum)
                        4'd0, 4'd1: next_state = 1'b0;
                        4'd2:       next_state = q[i*16 + j]; // stay same
                        4'd3:       next_state = 1'b1;
                        default:    next_state = 1'b0; // 4+
                    endcase
                end
                assign next_q[i*16 + j] = next_state;
            end
        end
    endgenerate
    
    always @(posedge clk) begin
        if (load)
            q <= data;
        else
            q <= next_q;
    end
endmodule
