
module TopModule (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  output walk_left,
  output walk_right
);
always @(posedge clk or posedge areset) begin
    if (areset) begin
        walk_left <= 1'b1;
        walk_right <= 1'b0;
    end
    else begin
        case ({walk_left, walk_right})
            2'b10: begin // walking left
                if (bump_left) begin
                    walk_left <= 1'b0;
                    walk_right <= 1'b1;
                end
                else begin
                    walk_left <= 1'b1;
                    walk_right <= 1'b0;
                end
            end
            2'b01: begin // walking right
                if (bump_right) begin
                    walk_left <= 1'b1;
                    walk_right <= 1'b0;
                end
                else begin
                    walk_left <= 1'b0;
                    walk_right <= 1'b1;
                end
            end
            default: begin // should not happen, but reset to walking left
                walk_left <= 1'b1;
                walk_right <= 1'b0;
            end
        endcase
    end
end
endmodule
