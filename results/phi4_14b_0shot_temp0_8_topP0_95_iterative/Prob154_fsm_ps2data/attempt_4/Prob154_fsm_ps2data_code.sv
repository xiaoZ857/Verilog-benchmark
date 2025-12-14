
module TopModule (
  input clk,
  input [7:0] in,
  input reset,
  output [23:0] out_bytes,
  output done
);
always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        current_state <= IDLE;
        done <= 0;
        out_bytes <= 24'b0; // Ensuring output bytes are reset
        byte1 <= 8'b0;      // Resetting internal registers for bytes
        byte2 <= 8'b0;
    end else begin
        case (current_state)
            COLLECT3: begin
                out_bytes <= {byte1, byte2, in};
                done <= 1; // Signal that a complete message is ready
            end
            default:
                done <= 0; // No message ready
        endcase

        // Update state after processing current state logic
        current_state <= next_state;
    end
end

always_comb begin
    next_state = current_state; // Default to staying in the same state
    
    case (current_state)
        IDLE: begin
            if (in[3] == 1) begin
                next_state = COLLECT1;
            end
        end
        
        COLLECT1: begin
            byte1 = in; // Assign first byte when entering this state
            next_state = COLLECT2;
        end

        COLLECT2: begin
            byte2 = in; // Assign second byte when entering this state
            next_state = COLLECT3;
        end
        
        COLLECT3: begin
            next_state = IDLE; // Return to IDLE after collecting all bytes
        end
    endcase
end

// Declaration of state variables and registers
typedef enum logic [1:0] {IDLE, COLLECT1, COLLECT2, COLLECT3} state_t;
state_t current_state, next_state;

logic [7:0] byte1, byte2;

// VERILOG-EVAL: endmodule not found
