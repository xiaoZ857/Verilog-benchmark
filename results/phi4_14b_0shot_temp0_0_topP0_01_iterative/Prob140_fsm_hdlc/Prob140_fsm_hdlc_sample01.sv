
module TopModule (
  input clk,
  input reset,
  input in,
  output disc,
  output flag,
  output err
);
always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        current_state <= IDLE;
        disc <= 1'b0;
        flag <= 1'b0;
        err <= 1'b0;
    end else begin
        // Update outputs based on the previous state
        case (current_state)
            ONE_11110: begin
                if (in == 0) begin
                    disc <= 1'b1; // Assert discard for one cycle
                end else begin
                    disc <= 1'b0;
                end
            end

            FLAG: begin
                flag <= 1'b1; // Assert flag for one cycle
            end

            ERROR: begin
                err <= 1'b1; // Assert error for one cycle
            end

            default: begin
                disc <= 1'b0;
                flag <= 1'b0;
                err <= 1'b0;
            end
        endcase

        // Transition to the next state
        current_state <= next_state;
    end
end

always_comb begin
    // Default outputs
    disc = 1'b0;
    flag = 1'b0;
    err = 1'b0;

    case (current_state)
        IDLE: begin
            if (in == 1) begin
                next_state = ONE_1;
            end else begin
                next_state = IDLE;
            end
        end

        ONE_1: begin
            if (in == 1) begin
                next_state = ONE_11;
            end else begin
                next_state = IDLE;
            end
        end

        ONE_11: begin
            if (in == 1) begin
                next_state = ONE_111;
            end else begin
                next_state = IDLE;
            end
        end

        ONE_111: begin
            if (in == 1) begin
                next_state = ONE_1111;
            end else begin
                next_state = IDLE;
            end
        end

        ONE_1111: begin
            if (in == 1) begin
                next_state = ONE_11110;
            end else if (in == 0) begin
                next_state = IDLE;
            end else begin
                next_state = ERROR;
            end
        end

        ONE_11110: begin
            if (in == 0) begin
                next_state = FLAG;
            end else if (in == 1) begin
                next_state = ERROR;
            end else begin
                next_state = IDLE;
            end
        end

        FLAG: begin
            if (in == 0) begin
                next_state = IDLE;
            end else begin
                next_state = ERROR;
            end
        end

        ERROR: begin
            next_state = IDLE;
        end

        default: begin
            next_state = IDLE;
        end
    endcase
end

// VERILOG-EVAL: endmodule not found
