
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output out_sop,
  output out_pos
);
// SOP: c·d + a'·b'·c·d' (from K-map grouping)
// POS: derive from SOP complement or directly from truth table
// Complement of out_sop: minterms where out=0 (0,1,4,5,6,9,10,13,14) plus don't cares? For POS, we group zeros.
// K-map zeros (with don't cares as 1? Actually for POS, we group zeros ignoring don't cares, but can use don't cares as zeros to make larger groups).
// Zeros at: 0000,0001,0100,0101,0110,1001,1010,1101,1110.
// Group zeros:
// Group1: ab=00, cd=00 and 01 → a'·b'·(c'·d' + c'·d) = a'·b'·c'
// Group2: ab=01, cd=00,01,10 → a'·b·(c'·d' + c'·d + c·d') = a'·b·(c' + d')? Let's compute: c'·d' + c'·d = c', plus c·d' → so a'·b·(c' + d')
// Group3: ab=10, cd=01,10 → a·b'·(c'·d + c·d') = a·b'·(c⊕d)
// Group4: ab=11, cd=01,10 → a·b·(c'·d + c·d') = a·b·(c⊕d)
// Combine group3 and group4: (a·b' + a·b)·(c⊕d) = a·(c⊕d)
// So zeros cover: a'·b'·c' + a'·b·(c' + d') + a·(c⊕d)
// Then out_pos = (a + b + c) · (a + b' + c + d) · (a' + c'·d + c·d')? This is messy.
// Alternatively, compute out_sop = c·d + a'·b'·c·d'
// Complement: out_sop' = (c·d + a'·b'·c·d')' = (c·d)' · (a'·b'·c·d')' = (c' + d') · (a + b + c' + d)
// Then out_pos = out_sop'? No, POS is product of sums for out, not complement.
// Actually, out_pos = (out_sop')'? That would give back SOP.
// Correct method: For POS, take maxterms where out=0 (ignore don't cares or include as 0 if helpful).
// Maxterms: M0,M1,M4,M5,M6,M9,M10,M13,M14.
// Write POS: (a+b+c+d)(a+b+c+d')(a+b'+c+d)(a+b'+c+d')(a+b'+c'+d)(a'+b+c+d')(a'+b+c'+d)(a'+b'+c+d')(a'+b'+c'+d)
// Minimize using K-map for zeros:
// From earlier zero groups: a'·b'·c' + a'·b·(c' + d') + a·(c⊕d)
// Complement to get out: out = (a'·b'·c')' · (a'·b·(c' + d'))' · (a·(c⊕d))'
// = (a+b+c) · (a+b' + (c·d)) · (a' + (c'·d' + c·d))  [since (c⊕d)' = c'·d' + c·d]
// This is not minimal POS.
// Let's derive minimal POS directly from K-map zeros:
// Group zeros as product of sums:
// For POS, we group adjacent zeros in K-map to form sum terms.
// Looking at K-map zeros:
// Group covering zeros at ab=00, cd=00 and 01: sum term = (a + b + c)  [since a=0,b=0,c=0 for both, d varies]
// Group covering zeros at ab=01, cd=00,01,10: sum term = (a + b' + c + d) ? Check: For ab=01 (a=0,b=1), zeros at cd=00 (c=0,d=0),01 (c=0,d=1),10 (c=1,d=0). To cover these, we need term that is

// VERILOG-EVAL: endmodule not found
