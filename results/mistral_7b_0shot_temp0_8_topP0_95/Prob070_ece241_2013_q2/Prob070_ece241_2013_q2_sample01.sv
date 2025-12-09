
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output out_sop,
  output out_pos
);

assign out_sop = a'b'c + abc'd + ac'bd + a'bcd; // SOP expression for desired outputs
assign out_pos = ~(a & b & c & d) & // POS expression for undesired output 0
                ~(a | b) &             // POS expression for undesired output 1
                ~(a & c & !(d)) &     // POS expression for undesired output 4
                ~(b & !(c)) &          // POS expression for undesired output 5
                ~(a & !c) &             // POS expression for undesired output 6
                ~(c & d & !(a)) &      // POS expression for undesired output 9
                ~(!b & c & !(d)) &     // POS expression for undesired output 10
                ~((!a | c) & b & !(d)) &// POS expression for undesired output 13
                !out_sop;              // Exclude the desired outputs from undesired outputs
endmodule

// VERILOG-EVAL: errant inclusion of module definition
