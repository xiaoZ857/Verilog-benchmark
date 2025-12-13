
module TopModule (
  input clk,
  input resetn,
  input [1:0] byteena,
  input [15:0] d,
  output reg [15:0] q
);

reg [15:0] upper_d [15:0]; // Upper byte (d[15:8])
reg [7:0] lower_d [15:0]; // Lower byte (d[7:0])

always @(posedge clk) begin
  if (!resetn) begin
    upper_d <= 8'b0; // Reset both bytes to zero
    lower_d <= 8'b0;
  end else begin
    if (byteena[1]) upper_d <= d [15:8]; // Write upper byte when byteena[1] is high
    if (byteena[0]) lower_d <= d [7:0]; // Write lower byte when byteena[0] is high
  end
end

always @(posedge clk) begin
  q <= upper_d [15:0]; // Assign the updated values to output register q
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
