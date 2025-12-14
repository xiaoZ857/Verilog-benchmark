
module TopModule (
  input [254:0] in,
  output reg [7:0] out
);
    // Combinational population‑count implementation
    always_comb begin
        // Initialise the accumulator
        out = 8'd0;

        // Count the number of 1‑bits in the 255‑bit input vector
        for (int i = 0; i < 255; i = i + 1) begin
            out = out + in[i];
        end
    end
endmodule
