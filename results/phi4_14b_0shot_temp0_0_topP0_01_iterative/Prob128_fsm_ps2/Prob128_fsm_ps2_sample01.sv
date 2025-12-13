
module TopModule (
  input clk,
  input [7:0] in,
  input reset,
  output done
);
always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        current_state <= IDLE;
        done <= 1'b0;
    end else begin
        // Set 'done' only when transitioning from RECEIVE_3 to IDLE after a valid message
        if (current_state == RECEIVE_3 && next_state == IDLE)
            done <= 1'b1;  // Assert done after the third byte of a valid message
        else
            done <= 1'b0;

        current_state <= next_state;
    end
end

always_comb begin
    case (current_state)
        IDLE: begin
            if (in[3]) begin
                next_state = RECEIVE_2;  // Start receiving a new message
            end else begin
                next_state = IDLE;
            end
        end

        RECEIVE_2: begin
            next_state = RECEIVE_3;  // Move to the third byte of the message
        end

        RECEIVE_3: begin
            next_state = IDLE;  // Return to IDLE after receiving the third byte
        end

        default: begin
            next_state = IDLE;  // Default case, should not occur
        end
    endcase
end

endmodule
