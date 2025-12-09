

module TopModule (
  input clk,
  input enable,
  input S,
  input A,
  input B,
  input C,
  output reg Z
);

reg [7:0] Q[8:0];
reg [2:0] ABC;

assign ABC = {A, B, C};

always @(posedge clk) begin
    if (enable) begin
        Q <= S;
    end else begin
        for (int i = 7; i >= 1; i--) begin
            Q[i] <= Q[i-1];
        end
        Q[0] <= '0;
    end
end

assign Z = {Q[2], Q[5], Q[8]};

// VERILOG-EVAL: endmodule not found
