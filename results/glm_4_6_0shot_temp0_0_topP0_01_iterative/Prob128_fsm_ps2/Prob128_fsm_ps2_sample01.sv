
module TopModule (
  input clk,
  input [7:0] in,
  input reset,
  output done
);

// FSM for PS/2 mouse protocol message boundary detection
reg [1:0] state;
reg [1:0] next_state;

// State encoding
localparam IDLE  = 2'b00;
localparam BYTE1 = 2'b01;
localparam BYTE2 = 2'b10;
localparam BYTE3 = 2'b11;

// State register
always @(posedge clk) begin
  if (reset)
    state <= IDLE;
  else
    state <= next_state;
end

// Next state logic
always @(*) begin
  next_state = state;
  case (state)
    IDLE: begin
      if (in[3])
        next_state = BYTE1;
    end
    BYTE1: begin
      next_state = BYTE2;
    end
    BYTE2: begin
      next_state = BYTE3;
    end
    BYTE3: begin
      if (in[3])
        next_state = BYTE1;
      else
        next_state = IDLE;
    end
  endcase
end

// Output logic
assign done = (state == BYTE3);

endmodule
