
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

always @(posedge clk) begin
    if (enable) begin
        for (int i = 7; i >= 0; i--) begin
            Q[i + 1] <= Q[i];
        end
        Q[0] <= S;
    end else begin
        for (int i = 8; i > 0; i--) begin
            Q[i - 1] <= Q[i];
        end
    end
end

reg [2:0] ABC;

assign ABC = A | B | C;

reg [7:0] Z;

always @(posedge clk) begin
    if (enable) begin
        case (ABC)
            000: Z = Q[0];
            001: Z = Q[1];
            010: Z = Q[2];
            011: Z = Q[3];
            100: Z = Q[4];
            101: Z = Q[5];
            110: Z = Q[6];
            111: Z = Q[7];
            default: Z = 0;
        endcase
    end else begin
        Z <= Q[7:0];
    end
end

endmodule
