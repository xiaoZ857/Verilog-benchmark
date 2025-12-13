
module TopModule (
  input clk,
  input reset,
  input data,
  output start_shifting
);

parameter IDLE = 3'b000;
parameter SAW_1 = 3'b001;
parameter SAW_11 = 3'b010;
parameter SAW_110 = 3'b011;
parameter FOUND = 3'b100;

reg [2:0] current_state, next_state;
reg start_shifting_reg;

// State transition logic
always @(posedge clk) begin
  if (reset) begin
    current_state <= IDLE;
    start_shifting_reg <= 1'b0;
  end else begin
    current_state <= next_state;
    if (next_state == FOUND) begin
      start_shifting_reg <= 1'b1;
    end
  end
end

// Next state logic
always @(*) begin
  next_state = current_state;
  
  case (current_state)
    IDLE: begin
      if (data == 1'b1)
        next_state = SAW_1;
      else
        next_state = IDLE;
    end
    
    SAW_1: begin
      if (data == 1'b1)
        next_state = SAW_11;
      else
        next_state = IDLE;
    end
    
    SAW_11: begin
      if (data == 1'b0)
        next_state = SAW_110;
      else
        next_state = SAW_11;
    end
    
    SAW_110: begin
      if (data == 1'b1)
       

// VERILOG-EVAL: endmodule not found
