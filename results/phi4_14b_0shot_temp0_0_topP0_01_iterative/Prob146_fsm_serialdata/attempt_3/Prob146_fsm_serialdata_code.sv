
module TopModule (
  input clk,
  input in,
  input reset,
  output [7:0] out_byte,
  output done
);
localparam IDLE = 3'b000;
localparam START_BIT = 3'b001;
localparam RECEIVE_DATA = 3'b010;
localparam STOP_BIT = 3'b011;
localparam CHECK_STOP = 3'b100;

reg [2:0] current_state, next_state;
reg [7:0] out_byte;
reg done;
reg [2:0] bit_counter;

always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        current_state <= IDLE;
        out_byte <= 8'b00000000;
        done <= 1'b0;
        bit_counter <= 3'b000;
    end else begin
        current_state <= next_state;

        case (current_state)
            IDLE: begin
                if (in == 1'b0) begin
                    next_state = START_BIT;
                end else begin
                    next_state = IDLE;
                end
                done <= 1'b0; // Ensure done is cleared in IDLE
            end

            START_BIT: begin
                if (in == 1'b0) begin
                    next_state = RECEIVE_DATA;
                end else begin
                    next_state = IDLE;
                end
            end

            RECEIVE_DATA: begin
                out_byte[bit_counter] <= in; // Capture each bit into the correct position
                bit_counter <= bit_counter + 3'b001;
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
                next_state = IDLE;
            end

            default: begin
                next_state = IDLE;
            end
        endcase
    end
end

endmodule
