
// TopModule.v
// 5‑to‑1 4‑bit combinational multiplexer
// Inputs: a,b,c,d,e   – 4‑bit data words
// Output: q           – 4‑bit result selected by c

module TopModule (
    input  [3:0] a,
    input  [3:0] b,
    input  [3:0] c,
    input  [3:0] d,
    input  [3:0] e,
    output reg [3:0] q
);

    always @* begin
        case (c)
            4'h0: q = b;   // when c == 0  -> output b
            4'h1: q = e;   // when c == 1  -> output e
            4'h2: q = a;   // when c == 2  -> output a
            4'h3: q = d;   // when c == 3  -> output d
            default: q = 4'hF;  // when c == 4..F -> output f
        endcase
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
