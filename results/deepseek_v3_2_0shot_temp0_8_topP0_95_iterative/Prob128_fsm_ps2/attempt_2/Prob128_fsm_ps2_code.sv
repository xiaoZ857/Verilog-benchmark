
module TopModule (
  input clk,
  input [7:0] in,
  input reset,
  output done
);
  reg [1:0] state;
  reg [1:0] next_state;
  
  localparam WAIT_BYTE1 = 2'd0;
  localparam WAIT_BYTE2 = 2'd1;
  localparam WAIT_BYTE3 = 2'd2;
  
  always @(*) begin
    case (state)
      WAIT_BYTE1: next_state = (in[3] == 1'b1) ? WAIT_BYTE2 : WAIT_BYTE1;
      WAIT_BYTE2: next_state = WAIT_BYTE3;
      WAIT_BYTE3: next_state = WAIT_BYTE1;
      default:    next_state = WAIT_BYTE1;
    endcase
  end
  
  always @(posedge clk) begin
    if (reset) begin
      state <= WAIT_BYTE1;
    end else begin
      state <= next_state;
    end
  end
  
  assign done = (state == WAIT_BYTE3);
endmodule
