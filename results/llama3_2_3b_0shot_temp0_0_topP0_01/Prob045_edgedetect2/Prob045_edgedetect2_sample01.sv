

module TopModule (
  input clk,
  input [7:0] in,
  output reg [7:0] anyedge
);

reg [7:0] anyedge;

always @(posedge clk) begin
    for (int i = 0; i < 8; i++) begin
        if ((in[i] == 1'b0) && (i[7:i] != 1'b0)) begin
            anyedge[i] <= 1;
        end else if ((in[i] == 1'b1) && (i[7:i] != 1'b1)) begin
            anyedge[i] <= 1;
        end else begin
            anyedge[i] <= 0;
        end
    end
end

assign anyedge = anyedge;

endmodule
