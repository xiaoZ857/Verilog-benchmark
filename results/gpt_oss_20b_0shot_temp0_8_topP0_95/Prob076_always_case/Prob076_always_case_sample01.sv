
// 6‑to‑1 multiplexer
//   sel  : 3‑bit select (0‑5 valid)
//   data0‑data5 : 4‑bit data inputs
//   out   : 4‑bit output, 0 if sel out of range
//
// All signals are combinational (positive‑edge triggered only if a clock is added).

module TopModule (
    input  wire [2:0] sel,
    input  wire [3:0] data0,
    input  wire [3:0] data1,
    input  wire [3:0] data2,
    input  wire [3:0] data3,
    input  wire [3:0] data4,
    input  wire [3:0] data5,
    output reg  [3:0] out
);

    // Combinational logic – use an always @(*) block
    always @(*) begin
        case (sel)
            3'd0: out = data0;
            3'd1: out = data1;
            3'd2: out = data2;
            3'd3: out = data3;
            3'd4: out = data4;
            3'd5: out = data5;
            default: out = 4'b0000;   // sel outside 0‑5 → output zero
        endcase
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
