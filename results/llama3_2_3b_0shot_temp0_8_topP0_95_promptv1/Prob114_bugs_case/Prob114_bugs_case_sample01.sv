
module TopModule (
  input [7:0] code,
  output reg [3:0] out,
  output reg valid
);
assign out = ((code == 8'h45) ? 4'b0000 : 
                (code == 8'h16) ? 4'b0010 : 
                (code == 8'h1e) ? 4'b0100 : 
                (code == 8'h26) ? 4'b1000 : 
                (code == 8'h25) ? 4'b1100 : 
                (code == 8'h2e) ? 4'b1001 : 
                (code == 8'h36) ? 4'b1110 : 
                (code == 8'h3d) ? 4'b1010 : 
                (code == 8'h3e) ? 4'b1101 : 
                (code == 8'h46) ? 4'b0001 : 
                4'b0000);
assign valid = out[3];

always @(posedge clk)
begin
    if (reset)
        out <= 4'b0000;
    else
        out <= out;
end

always @(clk or reset)
begin
    valid <= ~((code == 8'h45) || (code == 8'h16) || (code == 8'h1e) || 
               (code == 8'h26) || (code == 8'h25) || (code == 8'h2e) || 
               (code == 8'h36) || (code == 8'h3d) || (code == 8'h3e) || 
               (code == 8'h46));
end

// VERILOG-EVAL: endmodule not found
