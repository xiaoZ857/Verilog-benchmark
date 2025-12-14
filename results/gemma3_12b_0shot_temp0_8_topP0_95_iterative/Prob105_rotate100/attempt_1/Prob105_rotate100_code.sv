
module TopModule (
  input clk,
  input load,
  input [1:0] ena,
  input [99:0] data,
  output reg [99:0] q
);

  reg [99:0] register;

  always @(posedge clk) begin
    if (load) begin
      register <= data;
    end else begin
      case (ena)
        2'b01: begin // Rotate right by one bit
          register <= {register[98:0], register[99]};
        end
        2'b10: begin // Rotate left by one bit
          register <= {register[0], register[99:1]};
        end
        default: begin // No rotation
          register <= register;
        end
      endcase
    end
  end

  assign q = register;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
