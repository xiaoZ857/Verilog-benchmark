
module TopModule (
  input x,
  input y,
  output z
);
To implement the boolean function `z = (x ^ y) & x` in Verilog, we need to construct a module that takes two single-bit inputs, `x` and `y`, and produces a single-bit output `z` based on the given logical expression.

---

### **Understanding the Logic**

The expression `z = (x ^ y) & x` can be broken down as follows:

- `x ^ y` computes the **XOR** of `x` and `y`. This results in `1` when `x` and `y` are different, and `0` when they are the same.
- The result of the XOR is then **ANDed** with `x`. This means that the final output `z` will be `1` **only** when:
  - `x` is `1`, and
  - `x` and `y` are different (i.e., `y` is `0`

// VERILOG-EVAL: endmodule not found
