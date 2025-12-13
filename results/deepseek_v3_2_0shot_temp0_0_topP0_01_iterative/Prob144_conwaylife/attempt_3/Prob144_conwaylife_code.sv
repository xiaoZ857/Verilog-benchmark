
module TopModule (
  input clk,
  input load,
  input [255:0] data,
  output reg [255:0] q
);
    // Helper function to get the value of a cell given row and column with wrap-around
    function get_cell;
        input [7:0] row, col;
        reg [7:0] idx;
        reg [7:0] wrapped_row, wrapped_col;
        begin
            wrapped_row = row & 8'h0F; // wrap row to 0-15
            wrapped_col = col & 8'h0F; // wrap col to 0-15
            idx = wrapped_row * 16 + wrapped_col;
            get_cell = q[idx];
        end
    endfunction

    // Compute next state for all cells
    reg [255:0] next_q;
    integer r, c, idx;
    integer count;
    integer dr, dc;
    always @(*) begin
        for (r = 0; r < 16; r = r + 1) begin
            for (c = 0; c < 16; c = c + 1) begin
                idx = r * 16 + c;
                count = 0;
                // Check all 8 neighbors
                for (dr = -1; dr <= 1; dr = dr + 1) begin
                    for (dc = -1; dc <= 1; dc = dc + 1) begin
                        if (dr == 0 && dc == 0) continue;
                        if (get_cell(r + dr, c + dc) == 1'b1) begin
                            count = count + 1;
                        end
                    end
                end
                // Apply rules
                case (count)
                    0, 1: next_q[idx] = 1'b0;
                    2:    next_q[idx] = q[idx];
                    3:    next_q[idx] = 1'b1;
                    default: next_q[idx] = 1'b0;
                endcase
            end
        end
    end

    // Update state on clock edge
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= next_q;
        end
    end
endmodule
