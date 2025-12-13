
module TopModule (
  input clk,
  input in,
  input reset,
  output [7:0] out_byte,
  output done
);
always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        current_state <= IDLE;
        out_byte <= 8'b00000000;
        done <= 1'b0;
        bit_counter <= 3'b000;
    end else begin
        case (current_state)
            IDLE: begin
                if (in == 1'b0) begin
                    next_state = START_BIT;
                end else begin
                    next_state = IDLE;
                end
            end

            START_BIT: begin
                if (in == 1'b0) begin
                    next_state = RECEIVE_DATA;
                end else begin
                    next_state = IDLE;
                end
            end

            RECEIVE_DATA: begin
                out_byte[bit_counter] <= in;
                bit_counter <= bit_counter + 1'b1;
                if (bit_counter == 3'b111) begin
                    next_state = STOP_BIT;
                end else begin
                    next_state = RECEIVE_DATA;
                end
            end

            STOP_BIT: begin
                if (in == 1'b1) begin
                    next_state = CHECK_STOP;
                end else begin
                    // If stop bit is not correct, go back to IDLE
                    next_state = IDLE;
                end
            end

            CHECK_STOP: begin
                done <= 1'b1; // Assert done when a valid byte is received
                out_byte <= out_byte; // Ensure out_byte holds the last valid value
                next_state = IDLE;
            end

            default: begin
                next_state = IDLE;
            end
        endcase

        if (current_state != CHECK_STOP) begin
            done <= 1'b0; // Clear done unless in CHECK_STOP state
        end

        current_state <= next_state;
    end
end

always_comb begin
    case (current_state)
        IDLE: begin
            if (in == 1'b0) begin
                next_state = START_BIT;
            end else begin
                next_state = IDLE;
            end
        end

        START_BIT: begin
            if (in == 1'b0) begin
                next_state = RECEIVE_DATA;
            end else begin
                next_state = IDLE;
            end
        end

        RECEIVE_DATA: begin
            if (bit_counter == 3'b111) begin
                next_state = STOP_BIT;
            end else begin
                next_state = RECEIVE_DATA;
            end
        end

        STOP_BIT: begin
            if (in == 1'b1) begin
                next_state = CHECK_STOP;
            end else begin
                next_state = IDLE;
            end
        end

        CHECK_STOP: begin
            next_state = IDLE;
        end

        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule
