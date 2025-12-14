
module TopModule (
  input clk,
  input in,
  input reset,
  output [7:0] out_byte,
  output done
);

  always_comb begin
    // Default assignments
    next_state = state;
    next_bit_count = bit_count;
    next_data_reg = data_reg;
    
    case (state)
      IDLE: begin
        if (in == 0) begin  // Found start bit
          next_state = START;
          next_bit_count = 3'b000;
          next_data_reg = 8'b00000000;
        end
      end
      
      START: begin
        next_state = DATA;
      end
      
      DATA: begin
        // Shift in new bit (LSB first)
        next_data_reg = {in, data_reg[7:1]};
        next_bit_count = bit_count + 1;
        
        if (bit_count == 3'b111) begin  // Received all 8 bits
          next_state = STOP;
        end
      end
      
      STOP: begin
        if (in == 1) begin

// VERILOG-EVAL: endmodule not found
