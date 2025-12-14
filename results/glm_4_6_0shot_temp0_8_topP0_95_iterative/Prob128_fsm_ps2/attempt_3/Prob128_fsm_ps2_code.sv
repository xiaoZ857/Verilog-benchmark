
module TopModule (
  input clk,
  input [7:0] in,
  input reset,
  output done
);

// State machine to detect PS/2 mouse protocol message boundaries
// The FSM searches for 3-byte messages where the first byte has in[3]=1
// It signals done immediately after receiving the third byte of a valid message

// State encoding
localparam IDLE = 2'b00;  // Looking for byte 1 (in[3]=1)
localparam BYTE2 = 2'b01; // Found byte 1, waiting for byte 2
localparam BYTE3 = 2'b10; // Found byte 2, waiting for byte 3
localparam DONE = 2'b11;  // Signal complete message received

reg [1:0] state, next_state;
reg done;

// State transition logic
always @(posedge clk) begin
  if (reset) begin
    state <= IDLE;
  end else begin
    state <= next_state;
  end
end

// Next state and output logic
always @(*) begin
  // Default values
  next_state = state;
  done = 1'b0;
  
  case (state)
    IDLE: begin
      // Wait for byte with in[3]=1 (potential start of message)
      if (in[3]) begin
        next_state = BYTE2;
      end
    end
    
    BYTE2: begin
      // Any byte is accepted as byte 2
      next_state = BYTE3;
    end
    
    BYTE3: begin
      // Any byte is accepted as byte 3, then signal done
      next_state = DONE;
    end
    
    DONE: begin
      // Signal done for one cycle, then return to IDLE
      done = 1'b1;
      next_state = IDLE;
    end
  endcase
end

endmodule
