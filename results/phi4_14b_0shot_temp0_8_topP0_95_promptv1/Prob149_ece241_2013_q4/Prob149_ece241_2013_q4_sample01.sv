
module TopModule (
  input clk,
  input reset,
  input [3:1] s,
  output reg fr3,
  output reg fr2,
  output reg fr1,
  output reg dfr
);
always @(posedge clk or posedge reset) begin
    if (reset) begin
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b1;
    end else begin
        casez ({s[3], s[2], s[1]})
            3'b111: begin
                fr3 <= 1'b0; // Above s[3]
                fr2 <= 1'b0;
                fr1 <= 1'b0;
                dfr <= 1'b0;
            end
            3'b110, 3'b101: begin
                fr3 <= 1'b0; // Between s[3] and s[2]
                fr2 <= 1'b0;
                fr1 <= 1'b1;
                dfr <= 1'b0;
            end
            3'b011, 3'b010: begin
                fr3 <= 1'b0; // Between s[2] and s[1]
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                if (prev_s != {s[3], s[2], s[1]} && &{s[3], s[2], s[1]}) begin
                    dfr <= 1'b1; // Opening Supplemental valve if level increased from previous state
                end else begin
                    dfr <= 1'b0;
                end
            end
            3'b001, 3'b000: begin
                fr3 <= 1'b1; // Below s[1]
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b0;
            end
        endcase
    end
end

always @(posedge clk) begin
    prev_s <= {s[3], s[2], s[1]};
end

endmodule
