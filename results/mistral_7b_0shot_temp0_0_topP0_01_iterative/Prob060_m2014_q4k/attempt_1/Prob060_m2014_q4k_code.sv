
module TopModule (
  input wire clk,
  input wire resetn,
  input wire in,
  output reg [3:0] out
);

always @(posedge clk or negedge resetn) begin
  if (!resetn) begin
    out <= 4'b0001; // Reset value
  end else begin
    out[3] <= in; // Shift data into the most significant bit (MSB)
    out[0:2] <= out[1:3]; // Shift remaining bits to the left
  end
end

assign out = {out[3], out[2], out[1], out[0]}; // Reorder output bits for convenience

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
