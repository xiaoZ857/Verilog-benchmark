
module TopModule (
  input clk,
  input in,
  output logic out
);
// Implement the D flip-flop with a positive edge trigger and no reset.
module dff(
    input clk,
    input in,
    output logic out // Output of the D flip-flop
);

    logic q; // Internal state of the D flip-flop

    always_ff @(posedge clk) begin
        if(in == 1)
            q = 1;
        else if(q == 1 && !in)
            q = 0;
    end

    assign out = q;

endmodule

// Implement the XOR function using two inputs.
module xor(
    input wire in1, // Input 1 for the XOR operation
    input wire in2, // Input 2 for the XOR operation
    output wire out // Output of the XOR operation
);

    assign out = in1 ^ in2;

endmodule

// Define the TopModule that combines the above two modules.
module top_module(
    input clk, // Clock signal for the D flip-flop
    input in,   // Input to the XOR operation
    output logic out // Output of the XOR operation which is used as an input to the DFF
);

    xor U_XOR(in, out); // Create a XOR function

    dff U_DFF(out, in); // Create a D flip-flop with no reset

endmodule
