
module TopModule (
  input clk,
  input resetn,
  input [1:0] byteena,
  input [15:0] d,
  output reg [15:0] q
);

reg [7:0][15:0] q[16:0];

always @(posedge clk) begin
    if (!resetn) begin
        for (int i = 0; i < 17; i++) begin
            q[i] <= 1'b0;
        end
    end else begin
        for (int i = 0; i < 16; i++) begin
            if (byteena[0][i] == 1) begin
                q[i + 8] <= d[i];
            end
            if (byteena[1][i] == 1) begin
                q[i] <= d[i + 8];
            end
        end
    end
end

assign q[0] = q[16];
assign q[1] = q[15];

endmodule

// VERILOG-EVAL: errant inclusion of module definition
