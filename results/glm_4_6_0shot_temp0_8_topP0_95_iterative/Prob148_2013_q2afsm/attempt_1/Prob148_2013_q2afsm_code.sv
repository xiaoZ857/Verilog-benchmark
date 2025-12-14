
module TopModule (
  input clk,
  input resetn,
  input [3:1] r,
  output [3:1] g
);
  // State encoding
  parameter [1:0] A = 2'b00,
                   B = 2'b01,
                   C = 2'b10,
                   D = 2'b11;
  
  // State registers
  reg [1:0] current_state, next_state;
  
  // State transition logic (combinational)
  always @(*) begin
    case (current_state)
      A: begin
        if (r[1]) 
          next_state = B;  // Device 1 has highest priority
        else if (r[2]) 
          next_state = C;  // Device 2 has second priority
        else if (r[3]) 
          next_state = D;  // Device 3 has lowest priority
        else 
          next_state = A;  // No requests, stay in A
      end
      
      B: begin
        if (r[1]) 
          next_state = B;  // Keep granting device 1 if still requesting
        else 
          next_state = A;  // Return to A when device 1 stops requesting
      end
      
      C: begin
        if (r[2]) 
          next_state = C;  // Keep granting device 2 if still requesting
        else 
          next_state = A;  // Return to A when device 2 stops requesting
      end
      
      D: begin
        if (r[3]) 
          next_state = D;  // Keep granting device 3 if still requesting
        else 
          next_state = A;  // Return to A when device 3 stops requesting
      end
      
      default: 
        next_state = A;
    endcase
  end
  
  // State flip-flops (sequential)
  always @(posedge clk) begin
    if (!resetn) 
      current_state <= A;  // Reset to state A
    else 
      current_state <= next_state;
  end
  
  //

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
