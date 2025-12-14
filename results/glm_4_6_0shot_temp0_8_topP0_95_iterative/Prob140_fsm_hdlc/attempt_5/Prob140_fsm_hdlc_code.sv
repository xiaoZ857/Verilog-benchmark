
module TopModule (
  input clk,
  input reset,
  input in,
  output disc,
  output flag,
  output err
);

reg [3:0] current_state, next_state;
reg disc_reg, flag_reg, err_reg;

// State encoding
parameter IDLE = 4'd0;
parameter SAW_0 = 4'd1;
parameter SAW_01 = 4'd2;
parameter SAW_011 = 4'd3;
parameter SAW_0111 = 4'd4;
parameter SAW_01111 = 4'd5;
parameter SAW_011111 = 4'd6;
parameter SAW_0111110 = 4'd7;  // discard state
parameter SAW_01111110 = 4'd8; // flag state
parameter SAW_01111111 = 4'd9; // error state

always @(posedge clk) begin
  if (reset) begin
    current_state <= IDLE;
  end else begin
    current_state <= next_state;
  end
end

always @(*) begin
  next_state = current_state;
  
  case (current_state)
    IDLE: begin
      if (in == 0)
        next_state = SAW_0;
      else
        next_state = IDLE;
    end
    
    SAW_0: begin
      if (in == 0)
        next_state = SAW_0;
      else
        next_state = SAW_01;
    end
    
    SAW_01: begin
      if (in == 0)
        next_state = SAW_0;
      else
        next_state = SAW_011;
    end
    
    SAW_011: begin
      if (in == 0)
        next_state = SAW_0;
      else
        next_state = SAW_0111;
    end
    
    SAW_0111: begin
      if (in == 0)
        next_state = SAW

// VERILOG-EVAL: endmodule not found
