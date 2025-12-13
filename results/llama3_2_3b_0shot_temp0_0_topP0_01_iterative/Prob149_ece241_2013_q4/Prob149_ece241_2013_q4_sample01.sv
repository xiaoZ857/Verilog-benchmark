
module TopModule (
  input clk,
  input reset,
  input [3:1] s,
  output reg fr3,
  output reg fr2,
  output reg fr1,
  output reg dfr
);
reg [3:0] prev_s; // Previous sensors asserted

// Initialize state machine with default values
initial begin
    fr3 = 1;
    fr2 = 1;
    fr1 = 1;
    dfr = 0;
    prev_s <= 4'b0000; // Reset state machine to default values
end

always @(posedge clk) begin
    if (reset) begin
        prev_s <= 4'b0000; // Reset state machine to default values
    end else begin
        prev_s <= s; // Update previous sensors asserted
    end
    
    case (prev_s)
        4'b0000: // No sensors asserted, all four outputs asserted
            fr3 = 1;
            fr2 = 1;
            fr1 = 1;
            dfr = 0;
        
        4'b1000: // Sensors above s[3], input flow rate should be zero
            fr3 = 0;
            fr2 = 0;
            fr1 = 0;
            dfr = 0;
        
        4'b0100: // Sensors between s[3] and s[2]
            if (s == 4'b1001) begin // Previous level was lower than current
                fr3 = 1;
                dfr = 1;
            end else begin
                fr3 = 0;
                dfr = 0;
            end
        
        4'b0010: // Sensors between s[2] and s[1]
            if (s == 4'b0101) begin // Previous level was lower than current
                fr3 = 1;
                dfr = 1;
            end else begin
                fr3 = 0;
                dfr = 0;
            end
        
        4'b0001: // Sensors below s[1], flow rate should be at maximum
            if (s == 4'b0010) begin // Previous level was lower than current
                fr3 = 1;
                dfr = 1;
            end else begin
                fr3 = 0;
                dfr = 0;
            end
        
        default: // Invalid state, do nothing
            prev_s <= 4'b0000; // Reset to default value
    endcase
end

endmodule
