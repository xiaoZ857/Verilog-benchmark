
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
        out_bytes <= 24'b0;
    end else begin
        // Update state and outputs based on the current state
        case (current_state)
            COLLECT3: begin
                out_bytes <= {byte1, byte2, in}; 
                done <= 1; // Signal that a complete message is ready
            end
            default: begin
                done <= 0; // No message ready
            end
        endcase

        current_state <= next_state;
    end
end

always_comb begin
    next_state = current_state; // Default to staying in the same state
    
    case (current_state)
        IDLE: begin
            if (in[3] == 1) begin
                next_state = COLLECT1;
                byte1 = in; // Load first byte upon detecting a boundary
            end
        end

        COLLECT1: begin
            byte2 = in;
            next_state = COLLECT2;
        end

        COLLECT2: begin
            next_state = COLLECT3;
        end
        
        COLLECT3: begin
            next_state = IDLE; // Start over after completing a message
        end
    endcase
end

// VERILOG-EVAL: endmodule not found
