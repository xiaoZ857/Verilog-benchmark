
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output out_sop,
  output out_pos
);
First, let's list the truth table based on the description:

**Inputs (a,b,c,d) as a 4-bit number:**
- Output = 1 for inputs: 2 (0010), 7 (0111), 15 (1111)
- Output = 0 for inputs: 0 (0000), 1 (0001), 4 (0100), 5 (0101), 6 (0110), 9 (1001), 10 (1010), 13 (1101), 14 (1110)
- Don't cares for: 3 (0011), 8 (1000), 11 (1011), 12 (1100)

Let¡¯s write the minterms and maxterms:

**Minterms (1s):** m2, m7, m15  
**Maxterms (0s):** M0, M1, M4, M5, M6, M9, M10, M13, M14  
**Don¡¯t cares:** m3, m8, m11, m12

---

### Step 1: Sum-of-Products (SOP) minimization

K-map for SOP (with don't cares X):

Row order (ab as rows, cd as columns):  
ab\cd: 00 01 11 10  
00: 0  0  X  1  (m0,m1,m3,m2)  
01: 0  0  1  0  (m4,m5,m7,m6)  
11: X  X  1  X  (m12,m13,m15,m14)  
10: X  0  X  0  (m8,m9,m11,m10)

Fill:  
m2=1, m7=1, m15=1, others 0 except don't cares.

Grouping:

1. m15 (1111) with m7 (0111) ¡ú both have c=1,d=1, b=1? Wait m7: abcd=0111, m15=1111 ¡ú differ in a ¡ú term: b c d  
2. m15 (1111) with m11 (1011) don't care? m11 is X, so group m15+m11+m7+m3? Let's check carefully.

Better:  
Group 1: m15 (1111) + m7 (0111) ¡ú a' b c d + a b c d = b c d (since a varies)  
Group 2: m2 (0010) ¡ú a'b'c d' ¡ª can it be grouped? m3 (0011) is X, m10 (1010) is 0, so no 2-cell group with m2 except maybe m3? m3 is X, so m2+m3 = a'b'c (d varies) ¡ú a'b'c.

So SOP groups:  
- b c d (covers m7, m15)  
- a'b'c (covers m2, m3 don't care)

Check if m3 is covered by a'b'c? m3=0011, yes. m2=0010, yes.

So SOP minimal: out_sop = b c d + a' b' c

---

### Step 2: Product-of-Sums (POS) minimization

We use maxterms (0s) and don't cares as 1s if helpful.

Maxterms: M0(0000), M1(0001), M4(0100), M5(0101), M6(0110), M9(1001), M10(1010), M13(1101), M14(1110)

K-map for POS (0s in cells):

ab\cd: 00 01 11 10  
00: 0  0  X  1  
01: 0  0  1  0  
11: X  0  1  0  
10: X  0  X  0

0s at: (0,0), (0,1), (1,0), (1,1) in cd for ab=00? Wait, let's list 0s explicitly:

m0:00¡ú0, m1:01¡ú0, m4:01 in ab? Let's map carefully:

Actually easier: POS groups zeros:

Group zeros:

1. M0(0000), M4(0100) ¡ú differ in b ¡ú term: (a + c + d) ? Wait, for POS, we write sum terms where variable=0 if in all cells. Let's do properly:

For zeros:  
M0: abcd=0000 ¡ú sum term: (a+b+c+d)  
M4: abcd=0100 ¡ú sum term: (a+b'+c+d)  
They

// VERILOG-EVAL: endmodule not found
