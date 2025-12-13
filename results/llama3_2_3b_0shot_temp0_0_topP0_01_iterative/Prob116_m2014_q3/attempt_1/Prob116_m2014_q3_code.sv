
module TopModule (
  input [4:1] x, // x[3]x[2]
  output logic f
);

// Define a variable to hold the don't-care value
logic d;

// Calculate the don't-care value
assign d = (x[0] == 1) && (x[1] == 1) ? 1 : 0; // x[3]x[4]

// Calculate f based on the Karnaugh map
always_comb begin
    case(x[2])
        00: f = (x[3] & d) | ((~d) & (x[4]));
        01: f = (x[3] & x[4]) | (~d);
        11: f = (x[3] & ~d) | (x[4]);
        10: f = (x[3] & d) | ((~d) & x[4]);
    endcase
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
