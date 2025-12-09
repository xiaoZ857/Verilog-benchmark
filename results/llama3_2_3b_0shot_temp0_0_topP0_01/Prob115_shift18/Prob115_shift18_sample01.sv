

module TopModule (
  input clk,
  input load,
  input ena,
  input [1:0] amount,
  input [63:0] data,
  output reg [63:0] q
);

reg [63:0] q;

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end else if (ena && amount == 2'b00) begin
        q <= {q[62:0], data[0]};
    end else if (ena && amount == 2'b01) begin
        q <= data[8:1];
    end else if (ena && amount == 2'b10) begin
        q <= data[63:52];
    end else if (ena && amount == 2'b11) begin
        q <= {data[51:0], 32'd0};
    end
end

assign q = q;

// VERILOG-EVAL: endmodule not found
