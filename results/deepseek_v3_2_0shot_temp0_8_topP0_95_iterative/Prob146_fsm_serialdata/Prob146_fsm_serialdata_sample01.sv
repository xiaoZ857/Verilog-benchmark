
module TopModule (
  input clk,
  input in,
  input reset,
  output [7:0] out_byte,
  output done
);
    // States
    localparam IDLE = 2'b00;
    localparam DATA = 2'b01;
    localparam STOP = 2'b10;
    localparam ERROR = 2'b11;
    
    reg [1:0] state, next_state;
    reg [7:0] shift_reg;
    reg [3:0] bit_count;
    reg done_reg;
    reg [7:0] out_byte_reg;
    
    // State register
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            shift_reg <= 8'b0;
            bit_count <= 0;
            out_byte_reg <= 8'b0;
            done_reg <= 0;
        end else begin
            state <= next_state;
            
            // Shift register and bit counter logic
            case (state)
                IDLE: begin
                    shift_reg <= 8'b0;
                    bit_count <= 0;
                    done_reg <= 0;
                    if (in == 1'b0) begin
                        // Start bit detected, prepare for first data bit
                        // No shift yet - first data bit comes next cycle
                    end
                end
                DATA: begin
                    // Shift in current bit (LSB first)
                    shift_reg <= {in, shift_reg[7:1]};
                    bit_count <= bit_count + 1;
                    done_reg <= 0;
                end
                STOP: begin
                    // Check stop bit
                    if (in == 1'b1) begin
                        // Valid stop bit
                        out_byte_reg <= shift_reg;
                        done_reg <= 1'b1;
                    end else begin
                        // Invalid stop bit
                        done_reg <= 1'b0;
                    end
                    // Reset bit_count for next byte
                    bit_count <= 0;
                end
                ERROR: begin
                    done_reg <= 0;
                    // Wait for stop bit
                    if (in == 1'b1) begin
                        // Found stop bit, can now look for start bit
                        bit_count <= 0;
                    end
                end
                default: begin
                    // do nothing
                end
            endcase
        end
    end
    
    // Next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (in == 1'b0) // start bit detected
                    next_state = DATA;
                else
                    next_state = IDLE;
            end
            DATA: begin
                if (bit_count == 7) // after shifting in 8th bit (0-7 counts)
                    next_state = STOP;
                else
                    next_state = DATA;
            end
            STOP: begin
                if (in == 1'b1) // correct stop bit
                    next_state = IDLE;
                else // missing stop bit
                    next_state = ERROR;
            end
            ERROR: begin
                if (in == 1'b1) // finally found stop bit
                    next_state = IDLE;
                else
                    next_state = ERROR;
            end
            default: next_state = IDLE;
        endcase
    end
    
    // Outputs
    assign out_byte = out_byte_reg;
    assign done = done_reg;
endmodule
