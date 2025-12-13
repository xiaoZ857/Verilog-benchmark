
module TopModule (
  input clk,
  input [7:0] in,
  input reset,
  output [23:0] out_bytes,
  output done
);

  // FSM states
  typedef enum {
    IDLE,
    BYTE1_RECEIVED,
    BYTE2_RECEIVED,
    DONE
  } state_t;

  state_t state, next_state;
  
  // Byte storage
  reg [7:0] byte1, byte2, byte3;
  
  // Output signals
  reg [23:0] out_bytes_reg;
  reg done_reg;

  // Clock and reset handling
  always @(posedge clk) begin
    if (reset) begin
      state <= IDLE;
      byte1 <= 0;
      byte2 <= 0;
      byte3 <= 0;
      done_reg <= 0;
      out_bytes_reg <= 0;
    end else begin
      case (state)
        IDLE: begin
          if (in[3] == 1) begin
            next_state <= BYTE1_RECEIVED;
            byte1 <= in;
          end else begin
            next_state <= IDLE;
          end
        end
        
        BYTE1_RECEIVED: begin
          next_state <= BYTE2_RECEIVED;
          byte2 <= in;
        end
        
        BYTE2_RECEIVED: begin
          next_state <= DONE;
          byte3 <= in;
        end
        
        DONE: begin
          done_reg <= 1;
          out_bytes_reg <= {byte1, byte2, byte3};
          // After one cycle, transition back to IDLE
          if (in[3] == 1) begin
            next_state <= IDLE;
            done_reg <= 0;
          end else begin

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
