
module TopModule (
  input [3:0] a,
  input [3:0] b,
  input [3:0] c,
  input [3:0] d,
  input [3:0] e,
  output reg [3:0] q
);
    // Constant representing the value used for all other selections
    localparam [3:0] f = 4'b1111;

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
