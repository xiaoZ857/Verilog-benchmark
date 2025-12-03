

module TopModule (
  input clk,
  input reset,
  input [3:1] s,
  output reg fr3,
  output reg fr2,
  output reg fr1,
  output reg dfr
);

reg [1:0] prev_level = 2'b00; // Previous water level (initially low)
always @(posedge clk or posedge reset) begin
    if (reset) begin
        fr3 = fr2 = fr1 = dfr = 4'b0000; // Reset all outputs to inactive state
        prev_level <= 2'b00; // Reset previous level to low
    end else begin
        always @(posedge clk) begin
            if (s[3] && !s[2] && !s[1]) begin // Water level above s[3]
                fr3 = fr2 = fr1 = dfr = 4'b0000; // No flow rate or dfr
            end else if (!s[3] && s[2] && !s[1]) begin // Water level between s[3] and s[2]
                fr1 <= 1'b1; // Nominal flow rate fr1
            end else if (!s[3] && !s[2] && s[1]) begin // Water level between s[2] and s[1]
                fr1 <= 1'b1;
                fr2 <= 1'b1; // Nominal flow rate fr1 and fr2
            end else if (!s[3] && !s[2] && !s[1]) begin // Water level below s[1]
                fr1 <= 1'b1;
                fr2 <= 1'b1;
                fr3 <= 1'b1; // Nominal flow rate fr1, fr2 and fr3
            end

            if (s[1] && s[2] != prev_level) begin // Increase flow rate when level rises
                dfr <= 1'b1;
            end else begin
                dfr <= 1'b0; // Close supplemental flow valve when level doesn't rise
            end

            prev_level <= s[1:0]; // Update previous water level
        end
    end
end
endmodule
