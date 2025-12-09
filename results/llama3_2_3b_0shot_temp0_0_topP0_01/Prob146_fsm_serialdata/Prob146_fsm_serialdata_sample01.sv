

module TopModule (
  input clk,
  input in,
  input reset,
  output [7:0] out_byte,
  output done
);

always @(*) begin
    // State machine states
    enum logic [1:0] state {
        IDLE, START_BIT, DATA_BITS, STOP_BIT, VERIFIED
    } st;

    // Current state
    always @(*) st = state(IDLE);

    // Next state
    always @(*)
        case (st)
            IDLE:
                if (in == 1) st = START_BIT;
                else st = IDLE;
            START_BIT:
                if (in == 0) st = DATA_BITS;
                else st = START_BIT;
            DATA_BITS:
                if ($count_posedge(clk)) st = DATA_BITS;
                else if (in[7:0] == 8'd255) st = STOP_BIT;
                else st = DATA_BITS;
            STOP_BIT:
                if (in == 1) st = VERIFIED;
                else st = STOP_BIT;
            VERIFIED:
                if ($count_posedge(clk)) st = IDLE;
                else st = VERIFIED;
        endcase

    // Output logic
    always @(*) begin
        case (st)
            IDLE: out_byte <= 8'd0;
            START_BIT: out_byte <= 8'd0;
            DATA_BITS: out_byte <= in[7:0];
            STOP_BIT: out_byte <= 8'd255;
            VERIFIED:
                if (done == 1) out_byte <= out_byte;
        endcase
    end

    // Done signal logic
    always @(*) begin
        done = (st == VERIFIED);
    end

endmodule
