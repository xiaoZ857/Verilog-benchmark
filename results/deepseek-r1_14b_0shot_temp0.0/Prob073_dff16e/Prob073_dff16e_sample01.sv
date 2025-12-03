

module TopModule (
  input clk,
  input resetn,
  input [1:0] byteena,
  input [15:0] d,
  output reg [15:0] q
);

always @(posedge clk) begin
    if (!resetn) begin
        q_lower <= 0;
        q_upper <= 0;
    end else begin
        if (en_lower) begin
            q_lower <= d[7:0];
        end
        if (en_upper) begin
            q_upper <= d[15:8];
        end
    end
end

assign en_lower = byteena[0];
assign en_upper = byteena[1];

assign q = {q_upper, q_lower};

// VERILOG-EVAL: endmodule not found
