
module TopModule (
  input clk,
  input reset,
  input [3:1] s,
  output reg fr3,
  output reg fr2,
  output reg fr1,
  output reg dfr
);
  reg [3:1] s_prev;
  reg [1:0] state, next_state;
  
  localparam BELOW_S1      = 2'b00,
             BETWEEN_S1_S2 = 2'b01,
             BETWEEN_S2_S3 = 2'b10,
             ABOVE_S3      = 2'b11;
  
  // State transition logic
  always @(*) begin
    case (s)
      3'b000: next_state = BELOW_S1;
      3'b001: next_state = BETWEEN_S1_S2;
      3'b011: next_state = BETWEEN_S2_S3;
      3'b111: next_state = ABOVE_S3;
      default: next_state = BELOW_S1; // if illegal sensor pattern, treat as low
    endcase
  end
  
  // Sequential logic
  always @(posedge clk) begin
    if (reset) begin
      state <= BELOW_S1;
      s_prev <= 3'b000;
    end else begin
      state <= next_state;
      s_prev <= s;
    end
  end
  
  // Determine if water level was previously lower (rising)
  wire rising;
  assign rising = (s_prev == 3'b000 && s == 3'b001) ||
                  (s_prev == 3'b001 && s == 3'b011) ||
                  (s_prev == 3'b011 && s == 3'b111) ||
                  (s_prev == 3'b000 && s == 3'b011) ||
                  (s_prev == 3'b001 && s == 3'b111) ||
                  (s_prev == 3'b000 && s == 3'b111);
  
  // Output logic
  always @(*) begin
    case (state)
      BELOW_S1: begin
        fr3 = 1'b1;
        fr2 = 1'b1;
        fr1 = 1'b1;
        dfr = 1'b1;
      end
      BETWEEN_S1_S2: begin
        fr3 = 1'b0;
        fr2 = 1'b1;
        fr1 = 1'b1;
        dfr = rising ? 1'b1 : 1'b0;
      end
      BETWEEN_S2_S3: begin
        fr3 = 1'b0;
        fr2 = 1'b0;
        fr1 = 1'b1;
        dfr = rising ? 1'b1 : 1'b0;
      end
      ABOVE_S3: begin
        fr3 = 1'b0;
        fr2 = 1'b0;
        fr1 = 1'b0;
        dfr = 1'b0;
      end
      default: begin
        fr3 = 1'b0;
        fr2 = 1'b0;
        fr1 = 1'b0;
        dfr = 1'b0;
      end
    endcase
  end
endmodule
