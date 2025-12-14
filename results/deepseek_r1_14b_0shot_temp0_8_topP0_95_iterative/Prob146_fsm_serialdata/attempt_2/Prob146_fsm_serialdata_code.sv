
// Define timescale outside module
`timescale 1ns / 1ps

module TopModule (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // State definition
    typedef enum {
        IDLE,
        START_BIT,
        DATA_RECEIVING,
        STOP_BIT
    ) state_t;

    state_t state;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            done <= 0;
            out_byte <= 0;
        end else begin
            case (state)
                IDLE: begin
                    // Wait for start bit (falling edge from high to low)
                    if (~in) begin
                        state <= START_BIT;
                        done <= 0;
                    end
                end
                
                START_BIT: begin
                    // After detecting start bit, move to data receiving state
                    state <= DATA_RECEIVING;
                    done <= 0;
                    out_byte <= 0;
                end
                
                DATA_RECEIVING: begin
                    // Collect 8 data bits
                    if (in) begin
                        // Assuming LSB is received first
                        out_byte <= out_byte >> 1;
                        out_byte[0] <= in;
                    end
                    
                    // After receiving all 8 bits, move to stop bit state
                    if (out_byte == 0 && $countenanceposedge(in)) {
                        state <= STOP_BIT;
                    }
                end
                
                STOP_BIT: begin
                    // Wait for correct stop bit (high level)
                    if (~in) begin
                        state <= IDLE;
                        done <= 1;
                    end else begin
                        // Stay in this state until stop bit is found
                        out_byte <= 0;
                        done <= 1;
                    end
                end
            endcase
        end
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
