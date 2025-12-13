
module TopModule (
  input [7:0] a,
  input [7:0] b,
  output [7:0] s,
  output overflow
);
    // Perform a 9‑bit addition so that we can observe the carry out
    // of the most‑significant bit (MSB).  The 9‑bit result is
    // stored in sum_full[8:0] where:
    //   sum_full[7:0] – the 8‑bit sum (s)
    //   sum_full[8]   – carry out of the MSB
    wire [8:0] sum_full;
    assign sum_full = {1'b0, a} + {1'b0, b};

    // The 8‑bit sum is simply the lower 8 bits of the 9‑bit result.
    assign s = sum_full[7:0];

    // Signed overflow for two’s‑complement addition occurs when
    // the carry into the sign bit differs from the carry out of
    // the sign bit.  For a 9‑bit adder this is:
    //   overflow = carry_into_MSB XOR carry_out_of_MSB
    //   carry_into_MSB is sum_full[7] (the MSB of the 8‑bit sum),
    //   carry_out_of_MSB is sum_full[8].
    assign overflow = sum_full[8] ^ sum_full[7];

endmodule
