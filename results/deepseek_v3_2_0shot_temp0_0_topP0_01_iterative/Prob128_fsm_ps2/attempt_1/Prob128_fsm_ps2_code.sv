
module TopModule (
  input clk,
  input [7:0] in,
  input reset,
  output done
);
  reg [1:0] state, next_state;
  localparam WAIT_BYTE1 = 2'b00,
             WAIT_BYTE2 = 2'b01,
             WAIT_BYTE3 = 2'b10;
  
  always @(posedge clk) begin
    if (reset)
      state <= WAIT_BYTE1;
    else
      state <= next_state;
  end
  
  always @(*) begin
    case (state)
      WAIT_BYTE1: next_state = in[3] ? WAIT_BYTE2 : WAIT_BYTE1;
      WAIT_BYTE2: next_state = WAIT_BYTE3;
      WAIT_BYTE3: next_state = in[3] ? WAIT_BYTE2 : WAIT_BYTE1;
      default:    next_state = WAIT_BYTE1;
    endcase
  end
  
  assign done = (state == WAIT_BYTE3);
endmodule
