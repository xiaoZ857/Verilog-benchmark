
module TopModule (
  input [1023:0] in,
  input [7:0] sel,
  output [3:0] out
);

    parameter NUMSelects = 5;
    parameter NUMBitsPerInput = 4;
    parameter IN_WIDTH = NUMSELECTS * NUMBITSPERINPUT;

    // Define the signal for 'in' to be broken down into bits of the correct size
    assign out = {sel[3:0], sel[7:4], sel[11:8], sel[15:12]};

endmodule

// VERILOG-EVAL: errant inclusion of module definition
