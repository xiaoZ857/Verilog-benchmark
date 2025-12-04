
module TopModule (
  input clk,
  input [7:0] in,
  input reset,
  output done
);
  reg [1:0] state, next_state;
  localparam SEARCH = 2'b00,
             BYTE2  = 2'b01,
             BYTE3  = 2'b10,
             DONE   = 2'b11;
  
  always @(posedge clk) begin
    if (reset)
      state <= SEARCH;
    else
      state <= next_state;
  end
  
  always @(*) begin
    case (state)
      SEARCH: next_state = in[3] ? BYTE2 : SEARCH;
      BYTE2:  next_state = BYTE3;
      BYTE3:  next_state = DONE;
      DONE:   next_state = in[3] ? BYTE2 : SEARCH;
      default: next_state = SEARCH;
    endcase
  end
  
  assign done = (state == DONE);

// VERILOG-EVAL: endmodule not found
