
module TopModule (
  input [4:1] x,
  output logic f
);
We can simplify the Karnaugh map by treating don't-cares (d) as 1 or 0 to form the largest possible groups.

**Step 1 – Write the truth table from the given map**  
Variables order: x[3]x[4] as rows, x[1]x[2] as columns.

Let’s list minterms and don’t-cares:

From the map:

Row x[3]x[4] = 00 (00 means x[3]=0, x[4]=0):  
- x[1]x[2]=00 → d  
- x[1]x[2]=01 → 0  
- x[1]x[2]=11 → d  
- x[1]x[2]=10 → d  

Row 01 (x[3]=0, x[4]=1):  
- 00 → 0  
- 01 → d  
- 11 → 1  
- 10 → 0  

Row 11 (x[3]=1, x[4]=1):  
- 00 → 1  
- 01 → 1  
- 11 → d  
- 10 → d  

Row 10 (x[3]=1, x[4]=0):  
- 00 → 1  
- 01 → 1  
- 11 → 0  
- 10 → d  

**Step 2 – Grouping in K-map**  
We can cover all 1’s with minimal groups by choosing don’t-cares wisely.

1’s are at:  
(0,1,11) → (x3 x4 x1 x2) = (0 1 1 1) → m7? Wait, careful:  
Let’s assign bits as x[3] x[4] x[1] x[2] = A B C D.

From row 01, col 11 → A=0, B=1, C=1, D=1 → binary 0111 = 7.  
From row 11, col 00 → A=1, B=1, C=0, D=0 → 1100 = 12.  
From row 11, col 01 → A=1, B=1, C=0, D=1 → 1101 = 13.  
From row 10, col 00 → A=1, B=0, C=0, D=0 → 1000 = 8.  
From row 10, col 01 → A=1, B=0, C=0, D=1 → 1001 = 9.

Also row 01 col 11 already counted (7).  
Row 10 col 11 is 0, so not included.

So 1’s at m7, m12, m13, m8, m9.

Don’t-cares: from map:  
Row 00 col 00 (0000) d, col 11 (0011) d, col 10 (0010) d.  
Row 01 col 01 (0101) d.  
Row 11 col 11 (1111) d, col 10 (1110) d.  
Row 10 col 10 (1010) d.

**Step 3 – Grouping**  
Use K-map with AB (x[3]x[4]) as rows, CD (x[1]x[2]) as columns:

CD\AB  00  01  11  10  
00      d   0   1   1  
01      0   d   1   1  
11      d   1   d   0  
10      d   0   d   d  

Now group 1’s and d’s to make largest groups:

1. Group m8, m9, m12, m13:  
   This is A=1 (x[3]=1) and C=0 (x[1]=0) → covers AB=10,11 with CD=00,01.  
   So term: x[3] & ~x[1].

2. Group m7, m12, m13, and d at m15 (1111):  
   Actually m12, m13 already covered. Look at m7 (0111) and m15 (1111) d:  
   They form with m13 (1101), m12 (1100)? Not same group. Better: m7 with d at m3 (0011), m11 (1011) not 1. Let's check:  
   m7 (0111) and m15 (1111) d and m13 (1101) 1 and m5 (0101) d:  
   That’s actually: B=1 (x[4]=

// VERILOG-EVAL: endmodule not found
