
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output out_sop,
  output out_pos
);

// Define the conditions for logic-1 and logic-0
localparam [3:0] two = 2;
localparam [3:0] seven = 7;
localparam [3:0] fifteen = 15;

localparam [3:0] zero = 0;
localparam [3:0] one = 1;
localparam [3:0] four = 4;
localparam [3:0] five = 5;
localparam [3:0] six = 6;
localparam [3:0] nine = 9;
localparam [3:0] ten = 10;
localparam [3:0] thirteen = 13;
localparam [3:0] fourteen = 14;

// Define the conditions for numbers that never occur
localparam [3:0] three = 3;
localparam [3:0] eight = 8;
localparam [3:0] eleven = 11;
localparam [3:0] twelve = 12;

// Calculate out_sop in minimum sum-of-products form
assign out_sop = a[two] & b[two] & c[two] & d[two] |
                a[seven] & b[seven] & c[seven] & d[seven] |
                a[fifteen] & b[fifteen] & c[fifteen] & d[fifteen];

// Calculate out_pos in minimum product-of-sums form
assign out_pos = ~ (a[zero] | a[one] | a[four] | a[five] | a[six] |
                   a[nine] | a[tten] | a[thirteen] | a[fourteen]) & 
                 (~ b[zero] | b[one] | b[four] | b[five] | b[six] |
                  b[nine] | b[tten] | b[thirteen] | b[fourteen]) & 
                 (~ c[zero] | c[one] | c[four] | c[five] | c[six] |
                  c[nine] | c[tten] | c[thirteen] | c[fourteen]) & 
                 (~ d[zero] | d[one] | d[four] | d[five] | d[six] |
                  d[nine] | d[tten] | d[thirteen] | d[fourteen]);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
