
// TopModule.v
// 4‑bit wide 5‑to‑1 multiplexer
//   c = 0 → q = b
//   c = 1 → q = e
//   c = 2 → q = a
//   c = 3 → q = d
//   c = 4‑9 → q = f
// All other values of c also select f (default case).

module TopModule (
    input  wire [3:0] a,
    input  wire [3:0] b,
    input  wire [3:0] c,
    input  wire [3:0] d,
    input  wire [3:0] e,
    output reg  [3:0] q
);

    always @(*) begin
        case (c)
            4'd0: q = b;
            4'd1: q = e;
            4'd2: q = a;
            4'd3: q = d;
            default: q = f;   // covers 4‑9 and any other values
        endcase
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
