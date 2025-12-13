
module TopModule (
  input d,
  input done_counting,
  input ack,
  input [9:0] state, // 10-bit one-hot current state
  output B3_next,
  output S_next,
  output S1_next,
  output Count_next,
  output Wait_next,
  output done,
  output counting,
  output shift_ena
);

wire [9:0] next_state;

always @* begin
    case (state)
        // State transitions and outputs for each state
        10'b0000000001: begin  // S state
            B3_next = 0;
            S_next = 1;
            S1_next = 0;
            Count_next = 0;
            Wait_next = 0;
            done = 0;
            counting = 0;
            shift_ena = 0;
            if (d == 0) next_state = 10'b0000000001; // S
            else next_state = 10'b0000000010;          // S1
        end

        10'b0000000010: begin  // S1 state
            B3_next = 0;
            S_next = 0;
            S1_next = 1;
            Count_next = 0;
            Wait_next = 0;
            done = 0;
            counting = 0;
            shift_ena = 0;
            if (d == 0) next_state = 10'b0000000001; // S
            else next_state = 10'b0000000100;          // S11
        end

        10'b0000000100: begin  // S11 state
            B3_next = 0;
            S_next = 0;
            S1_next = 1;
            Count_next = 0;
            Wait_next = 0;
            done = 0;
            counting = 0;
            shift_ena = 0;
            next_state = 10'b0000000100; // S11 (loop on d=1)
        end

        10'b0000000100: begin  // S11 state
            B3_next = 0;
            S_next = 0;
            S1_next = 1;
            Count_next = 0;
            Wait_next = 0;
            done = 0;
            counting = 0;
            shift_ena = 0;
            if (d == 0) next_state = 10'b0000001000; // S110
           

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
