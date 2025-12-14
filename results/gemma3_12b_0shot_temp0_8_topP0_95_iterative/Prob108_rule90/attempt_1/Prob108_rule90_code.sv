
module TopModule (
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q
);

  reg [511:0] next_q;

  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      q <= next_q;
    end
  end

  always @(*) begin
    for (int i = 0; i < 512; i++) begin
      case (q[i])
        1'b0: begin
          if (q[i-1] == 1'b0 && q[i+1] == 1'b0)
            next_q[i] = 1'b0;
          else if (q[i-1] == 1'b0 && q[i+1] == 1'b1)
            next_q[i] = 1'b1;
          else if (q[i-1] == 1'b1 && q[i+1] == 1'b0)
            next_q[i] = 1'b0;
          else
            next_q[i] = 1'b1;
        end
        1'b1: begin
          if (q[i-1] == 1'b1 && q[i+1] == 1'b1)
            next_q[i] = 1'b0;
          else if (q[i-1] == 1'b1 && q[i+1] == 1'b0)
            next_q[i] = 1'b1;
          else if (q[i-1] == 1'b0 && q[i+1] == 1'b1)
            next_q[i] = 1'b0;
          else
            next_q[i] = 1'b1;
        end
      endcase
    }
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
