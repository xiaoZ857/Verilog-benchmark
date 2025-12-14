
module TopModule (
  input clk,
  input [7:0] in,
  input reset,
  output reg done
);

// State encoding
localparam IDLE = 2'b00;
localparam RECEIVE_1 = 2'b01;
localparam RECEIVE_2 = 2'b10;
localparam RECEIVE_3 = 2'b11;

reg [1:0] current_state, next_state;

always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        current_state <= IDLE;
        done <= 1'b0;
    end else begin
        // Update 'done' signal only when transitioning from RECEIVE_3 to the next state
        if (current_state == RECEIVE_3 && next_state != RECEIVE_3) begin
            done <= 1'b1;  // Asserted immediately after the third byte is received
        end else begin
            done <= 1'b0;
        end

        current_state <= next_state;
    end
end

always_comb begin
    // Default assignments for next state and outputs
    next_state = current_state;

    case (current_state)
        IDLE: begin
            if (in[3] == 1) begin
                next_state = RECEIVE_1;  // Transition to RECEIVE_1 on start byte detection
            end else begin
                next_state = IDLE;
            end
        end

        RECEIVE_1: begin
            next_state = RECEIVE_2;  // Continue to the second byte of the message
        end

        RECEIVE_2: begin
            next_state = RECEIVE_3;  // Continue to the third byte of the message
        end

        RECEIVE_3: begin
            next_state = IDLE;  // Return to IDLE after receiving a full message
        end

        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
