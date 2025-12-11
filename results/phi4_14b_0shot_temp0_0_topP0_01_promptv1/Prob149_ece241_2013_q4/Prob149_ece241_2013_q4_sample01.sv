
module TopModule (
  input clk,
  input reset,
  input [3:1] s,
  output reg fr3,
  output reg fr2,
  output reg fr1,
  output reg dfr
);
reg [2:0] current_state, next_state;

always @(posedge clk or posedge reset) begin
    if (reset)
        current_state <= 3'b000;
    else
        current_state <= next_state;
end

always @(*) begin
    case (current_state)
        3'b000: // Below s[1]
            next_state = (s == 3'b001) ? 3'b010 : 3'b000;

        3'b001: // Between s[2] and s[1]
            next_state = (s == 3'b011) ? 3'b100 :
                         (s == 3'b001) ? 3'b001 :
                         (s == 3'b000) ? 3'b000 : 3'b001;

        3'b010: // Between s[3] and s[2]
            next_state = (s == 3'b011) ? 3'b100 :
                         (s == 3'b010) ? 3'b010 :
                         (s == 3'b000) ? 3'b000 : 3'b001;

        3'b100: // Above s[3]
            next_state = (s != 3'b111) ? 3'b010 : 3'b100;
        
        default:
            next_state = 3'b000;
    endcase
end

always @(*) begin
    fr1 = 0;
    fr2 = 0;
    fr3 = 0;
    dfr = 0;

    case (current_state)
        3'b000: begin // Below s[1]
            fr1 = 1;
            fr2 = 1;
            fr3 = 1;
        end

        3'b001: begin // Between s[2] and s[1]
            fr1 = 1;
            fr2 = 1;
        end

        3'b010: begin // Between s[3] and s[2]
            fr1 = 1;
        end

        3'b100: begin // Above s[3]
            // No flow
        end
    endcase

    if (current_state != next_state) begin
        dfr = 1; // Open supplemental valve on level increase
    end else begin
        dfr = 0;
    end
end

endmodule
