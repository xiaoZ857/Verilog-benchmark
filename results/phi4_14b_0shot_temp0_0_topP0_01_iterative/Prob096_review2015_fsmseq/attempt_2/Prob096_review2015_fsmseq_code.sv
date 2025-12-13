
module TopModule (
  input clk,
  input reset,
  input data,
  output start_shifting
);
always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        current_state <= IDLE;
        start_shifting <= 0; // Ensure output is cleared on reset
    end else begin
        current_state <= next_state;
        if (current_state == FOUND) begin
            start_shifting <= 1; // Set output when sequence is found
        end else begin
            start_shifting <= 0; // Clear output otherwise
        end
    end
end

always_comb begin
    case (current_state)
        IDLE: begin
            if (data == 1'b1) begin
                next_state = S1;
            end else begin
                next_state = IDLE;
            end
        end

        S1: begin
            if (data == 1'b1) begin
                next_state = S11;
            end else begin
                next_state = IDLE; // Reset to IDLE on '0'
            end
        end

        S11: begin
            if (data == 1'b0) begin
                next_state = S110;
            end else begin
                next_state = S11; // Stay in S11 on another '1'
            end
        end

        S110: begin
            if (data == 1'b1) begin
                next_state = FOUND;
            end else begin
                next_state = IDLE; // Reset to IDLE on '0'
            end
        end

        FOUND: begin
            next_state = FOUND; // Remain in FOUND state until reset
        end

        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule
