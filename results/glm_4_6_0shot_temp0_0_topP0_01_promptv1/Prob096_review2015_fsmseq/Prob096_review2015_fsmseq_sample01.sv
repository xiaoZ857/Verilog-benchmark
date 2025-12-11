
module TopModule (
  input clk,
  input reset,
  input data,
  output start_shifting
);

  reg [2:0] state, next_state;
  reg start_shifting_reg;
  
  // State encoding
  localparam IDLE = 3'b000;
  localparam SAW_1 = 3'b001;
  localparam SAW_11 = 3'b010;
  localparam SAW_110 = 3'b011;
  localparam FOUND = 3'b100;
  
  // State register
  always @(posedge clk) begin
    if (reset) begin
      state <= IDLE;
      start_shifting_reg <= 1'b0;
    end else begin
      state <= next_state;
      if (next_state == FOUND) begin
        start_shifting_reg <= 1'b1;
      end
    end
  end
  
  // Next state logic
  always @(*) begin
    case (state)
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
          next_state = FOUND;
        else
          next_state = IDLE;
      end
      
      FOUND: begin
        next_state = FOUND;
      end
      
      default: begin
        next_state = IDLE;
      end
    endcase
  end
  
  // Output assignment
  assign start_shifting = start_shifting_reg;
  
endmodule
