
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
        out_bytes <= 24'b0;
        done <= 1'b0;
        byte1 <= 8'b0;
        byte2 <= 8'b0;
    end else begin
        case (current_state)
            COLLECT_3: begin
                if (done) begin
                    out_bytes <= {byte1, byte2, in}; // Assign output when done is true
                end
            end
            default: begin
                out_bytes <= 24'b0; // Clear outputs when not done
            end
        endcase

        current_state <= next_state;

        if (current_state == COLLECT_3) begin
            done <= 1'b1; // Assert done immediately after collecting the third byte
        end else if (next_state == IDLE) begin
            done <= 1'b0; // Deassert done when transitioning to IDLE
        end
    end
end

always_comb begin
    next_state = current_state; // Default to stay in the same state
    case (current_state)
        IDLE: begin
            if (in[3] == 1'b1) begin
                next_state = COLLECT_1;
            end
        end
        COLLECT_1: begin
            byte1 = in; // Store first byte
            next_state = COLLECT_2;
        end
        COLLECT_2: begin
            byte2 = in; // Store second byte
            next_state = COLLECT_3;
        end
        COLLECT_3: begin
            if (in[3] == 1'b1) begin
                next_state = IDLE; // Transition back to IDLE only if a new message boundary is detected
            end else begin
                next_state = COLLECT_1; // Continue collecting bytes for the current message
            end
        end
    endcase
end

endmodule
