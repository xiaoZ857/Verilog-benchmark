
module TopModule (
  input clk,
  input [7:0] in,
  input reset,
  output [23:0] out_bytes,
  output done
);
  reg [1:0] state, next_state;
  reg [23:0] msg_reg;
  reg done_reg;
  
  localparam WAIT = 2'b00,
             BYTE2 = 2'b01,
             BYTE3 = 2'b10;
  
  // State register
  always @(posedge clk) begin
    if (reset) begin
      state <= WAIT;
    end else begin
      state <= next_state;
    end
  end
  
  // Next state logic
  always @(*) begin
    case (state)
      WAIT: begin
        if (in[3]) next_state = BYTE2;
        else       next_state = WAIT;
      end
      BYTE2: next_state = BYTE3;
      BYTE3: next_state = WAIT;
      default: next_state = WAIT;
    endcase
  end
  
  // Datapath: store bytes
  always @(posedge clk) begin
    if (reset) begin
      msg_reg <= 24'b0;
    end else begin
      case (state)
        WAIT: begin
          if (in[3]) msg_reg[23:16] <= in;
        end
        BYTE2: msg_reg[15:8] <= in;
        BYTE3: msg_reg[7:0] <= in;
        default: msg_reg <= msg_reg;
      endcase
    end
  end
  
  // Done signal: asserted in the cycle after third byte is stored
  always @(posedge clk) begin
    if (reset) begin
      done_reg <= 1'b0;
    end else begin
      done_reg <= (state == BYTE3);
    end
  end
  
  assign out_bytes = msg_reg;
  assign done = done_reg;
endmodule
