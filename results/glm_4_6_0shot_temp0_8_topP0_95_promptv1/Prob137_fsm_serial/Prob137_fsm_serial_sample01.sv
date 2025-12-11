
module TopModule (
  input clk,
  input in,
  input reset,
  output done
);

reg [2:0] state, next_state;
reg [3:0] bit_count;
reg done_reg;

parameter IDLE = 3'b000;
parameter DATA = 3'b001;
parameter STOP = 3'b010;
parameter ERROR = 3'b011;

// State register
always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 4'b0000;
    end else begin
        state <= next_state;
        if (state == DATA && next_state == DATA) begin
            bit_count <= bit_count + 1;
        end else if (next_state == DATA) begin
            bit_count <= 4'b0000;
        end else begin
            bit_count <= bit_count;
        end
    end
end

// Next state logic
always @(*) begin
    case (state)
        IDLE: begin
            if (in == 1'b0)  // Start bit detected
                next_state = DATA;
            else
                next_state = IDLE;
        end
        
        DATA: begin
            if (bit_count == 4'b1000)  // Received 8 data bits
                next_state = STOP;
            else
                next_state = DATA;
        end
        
        STOP: begin
            if (in == 1'b1) begin  // Correct stop bit
                next_state = IDLE;
            end else begin  // Incorrect stop bit
                next_state = ERROR;
            end
        end
        
        ERROR: begin
            if (in == 1'b1)  // Found stop bit
                next_state = IDLE;
            else
                next_state = ERROR;
        end
        
        default: next_state = IDLE;
    endcase
end

// Output logic
always @(posedge clk) begin
    if (reset) begin
        done_reg <= 1'b0;
    end else begin
        if (state == STOP && next_state == IDLE && in == 1'b1) begin
            done_reg <= 1'b1;
        end else begin
            done_reg <= 1'b0;
        end
    end
end

assign done = done_reg;

endmodule
