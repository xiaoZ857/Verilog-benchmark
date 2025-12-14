
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
parameter SAW_0111111 = 4'd7;
parameter DISCARD_STATE = 4'd8;
parameter FLAG_STATE = 4'd9;
parameter ERROR_STATE = 4'd10;

always @(posedge clk) begin
  if (reset) begin
    current_state <= IDLE;
    disc_reg <= 0;
    flag_reg <= 0;
    err_reg <= 0;
  end else begin
    current_state <= next_state;
    disc_reg <= 0;
    flag_reg <= 0;
    err_reg <= 0;
    
    case (next_state)
      DISCARD_STATE: disc_reg <= 1;
      FLAG_STATE: flag_reg <= 1;
      ERROR_STATE: err_reg <= 1;
    endcase
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

// VERILOG-EVAL: endmodule not found
