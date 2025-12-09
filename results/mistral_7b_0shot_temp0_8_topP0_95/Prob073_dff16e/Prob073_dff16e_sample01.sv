
module TopModule (
  input wire clk,
  input wire resetn,
  input [1:0] byteena,
  input [15:0] d,
  output reg [15:0] q
);

reg [15:0] d_upper [15:0]; // store upper byte of data for each DFF
reg [15:0] d_lower [15:0]; // store lower byte of data for each DFF

always @(posedge clk) begin
  if (!resetn) begin
    // reset all flip-flops to zero
    d_upper <= 0;
    d_lower <= 0;
  end else begin
    // set data for upper byte when byteena[1] is high
    if (byteena[1]) d_upper <= d[15:8];

    // set data for lower byte when byteena[0] is high
    if (byteena[0]) d_lower <= d[7:0];
  end
end

assign q = d_upper | d_lower; // concatenate upper and lower bytes to output

endmodule

// VERILOG-EVAL: errant inclusion of module definition
