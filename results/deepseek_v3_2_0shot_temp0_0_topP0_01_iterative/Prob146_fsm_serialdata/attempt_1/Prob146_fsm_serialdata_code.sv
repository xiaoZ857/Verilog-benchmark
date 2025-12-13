
module TopModule (
  input clk,
  input in,
  input reset,
  output [7:0] out_byte,
  output done
);
    reg [2:0] state, next_state;
    reg [7:0] data_reg;
    reg [3:0] bit_cnt;
    reg done_reg;
    
    // State definitions
    localparam IDLE      = 3'b000;
    localparam START     = 3'b001;
    localparam DATA      = 3'b010;
    localparam STOP      = 3'b011;
    localparam ERROR     = 3'b100;
    
    // State register
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end
    
    // Data register and bit counter
    always @(posedge clk) begin
        if (reset) begin
            data_reg <= 8'b0;
            bit_cnt <= 4'b0;
        end else begin
            case (state)
                IDLE: begin
                    data_reg <= 8'b0;
                    bit_cnt <= 4'b0;
                end
                START: begin
                    data_reg <= 8'b0;
                    bit_cnt <= 4'b0;
                end
                DATA: begin
                    // Shift in LSB first
                    data_reg <= {in, data_reg[7:1]};
                    bit_cnt <= bit_cnt + 1;
                end
                default: begin
                    data_reg <= data_reg;
                    bit_cnt <= bit_cnt;
                end
            endcase
        end
    end
    
    // Next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (in == 1'b0) begin
                    next_state = START;
                end else begin
                    next_state = IDLE;
                end
            end
            START: begin
                // After start bit, go to DATA state
                next_state = DATA;
            end
            DATA: begin
                if (bit_cnt == 4'd8) begin
                    // Collected 8 bits, check stop bit
                    next_state = STOP;
                end else begin
                    next_state = DATA;
                end
            end
            STOP: begin
                if (in == 1'b1) begin
                    // Valid stop bit
                    next_state = IDLE;
                end else begin
                    // Missing stop bit, wait in ERROR state
                    next_state = ERROR;
                end
            end
            ERROR: begin
                // Wait until a stop bit (1) is found
                if (in == 1'b1) begin
                    next_state = IDLE;
                end else begin
                    next_state = ERROR;
                end
            end
            default: next_state = IDLE;
        endcase
    end
    
    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            done_reg <= 1'b0;
        end else begin
            // Assert done when we are in STOP state and stop bit is valid
            if (state == STOP && in == 1'b1) begin
                done_reg <= 1'b1;
            end else begin
                done_reg <= 1'b0;
            end
        end
    end
    
    assign out_byte = data_reg;
    assign done = done_reg;
endmodule
