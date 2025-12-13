
module TopModule (
  input in,
  input [9:0] state,
  output reg [9:0] next_state,
  output reg out1,
  output reg out2
);

  always @(*) begin
    // Default assignments for outputs and next_state
    {out1, out2} = 2'b00;
    next_state = 10'b0000000000;

    case (state)
      10'b0000000001: begin // S0
        if (in == 1) 
          next_state = 10'b0000000010; // Transition to S1
      end

      10'b0000000010: begin // S1
        if (in == 1)
          next_state = 10'b0000000100; // Transition to S2
      end

      10'b0000000100: begin // S2
        if (in == 1)
          next_state = 10'b0000001000; // Transition to S3
      end

      10'b0000001000: begin // S3
        if (in == 1)
          next_state = 10'b0000010000; // Transition to S4
      end

      10'b0000010000: begin // S4
        if (in == 1)
          next_state = 10'b0000100000; // Transition to S5
      end

      10'b0000100000: begin // S5
        if (in == 0)
          next_state = 10'b0001000000; // Transition to S8
        else
          next_state = 10'b0010000000; // Transition to S6
      end

      10'b0010000000: begin // S6
        if (in == 0)
          next_state = 10'b0100000000; // Transition to S9
        else
          next_state = 10'b1000000000; // Transition to S7
      end

      10'b1000000000: begin // S7
        {out1, out2} = 2'b01;
        if (in == 0)
          next_state = 10'b0000000001; // Transition to S0
        else
          next_state = 10'b1000000000; // Remain in S7
      end

      10'b0001000000: begin // S8
        {out1, out2} = 2'b10;
        if (in == 0)
          next_state = 10'b0000000001; // Transition to S0
        else
          next_state = 10'b0000000010; // Transition to S1
      end

      10'b0100000000: begin // S9
        {out1, out2} = 2'b11;
        if (in == 0)
          next_state = 10'b0000000001; // Transition to S0
        else
          next_state = 10'b0000000010; // Transition to S1
      end

      default: begin
        next_state = 10'b0000000001; // Default transition to S0
      end
    endcase
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
