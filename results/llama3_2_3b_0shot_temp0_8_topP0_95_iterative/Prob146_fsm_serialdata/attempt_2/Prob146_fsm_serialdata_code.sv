
module TopModule (
  input clk,
  input in,
  input reset,
  output [7:0] out_byte,
  output done
);
// Finite State Machine for Serial Communication Protocol
always_comb {
    assign next_state = case (state)
        IDLE : {in, 2'b00}
        START_BIT: {in, 2'b01}
        DATA_BYTE: {in, 2'b10}
        STOP_BIT: {in, 2'b11};
    endcase;
}

always @(posedge clk or @posedge in) // Clock edge and input change
begin: always_edge
    if (next_state != state)
        state <= next_state;
    else if ((in == 1 && state == START_BIT) || (in == 0 && state == STOP_BIT))
        state <= IDLE; // Stop bit received, end of byte
end

always (posedge clk or @posedge in) // Clock edge and input change
begin: always_edge
    if (state == DATA_BYTE)
        out_byte[7] <= in;
    else if ((in == 0 && state == STOP_BIT && out_byte[7] != 1))
        state <= IDLE; // Stop bit not received, reset and wait for next byte

endmodule
