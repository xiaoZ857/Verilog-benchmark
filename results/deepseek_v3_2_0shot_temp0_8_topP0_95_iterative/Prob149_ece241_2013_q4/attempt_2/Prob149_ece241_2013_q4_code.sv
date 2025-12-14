
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
      fr3 <= 1;
      fr2 <= 1;
      fr1 <= 1;
      dfr <= 1;
      prev_s <= 3'b000;
    end else begin
      prev_s <= s;
      
      case (s)
        3'b111: begin
          fr3 <= 0;
          fr2 <= 0;
          fr1 <= 0;
          dfr <= 0;
        end
        3'b011: begin
          fr3 <= 0;
          fr2 <= 0;
          fr1 <= 1;
          dfr <= (prev_s < s) ? 1 : 0;
        end
        3'b001: begin
          fr3 <= 0;
          fr2 <= 1;
          fr1 <= 1;
          dfr <= (prev_s < s) ? 1 : 0;
        end
        3'b000: begin
          fr3 <= 1;
          fr2 <= 1;
          fr1 <= 1;
          dfr <= 1;
        end
        default: begin
          fr3 <= 1;
          fr2 <= 1;
          fr1 <= 1;
          dfr <= 1;
        end
      endcase
    end
  end

endmodule
