
module TopModule (
  input clk,
  input reset,
  input [3:1] s,
  output reg fr3,
  output reg fr2,
  output reg fr1,
  output reg dfr
);
always @(posedge clk) begin
    if (reset) begin
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b1;
    end else begin
        // Default outputs to 0
        fr3 <= 1'b0;
        fr2 <= 1'b0;
        fr1 <= 1'b0;
        dfr <= 1'b0;

        // Determine current water level based on sensors
        if (s[1] && s[2] && s[3]) begin
            // Above s[3] - all sensors asserted, no flow outputs
            fr3 <= 1'b0;
            fr2 <= 1'b0;
            fr1 <= 1'b0;
            dfr <= 1'b0;
        end else if (s[1] && s[2]) begin
            // Between s[3] and s[2] - s[1] and s[2] asserted
            fr3 <= 1'b0;
            fr2 <= 1'b0;
            fr1 <= 1'b1;
            dfr <= 1'b0;
        end else if (s[1]) begin
            // Between s[2] and s[1] - only s[1] asserted
            fr3 <= 1'b0;
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            dfr <= 1'b0;
        end else begin
            // Below s[1] - no sensors asserted
            fr3 <= 1'b1;
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            dfr <= 1'b1;
        end
    end
end

endmodule
