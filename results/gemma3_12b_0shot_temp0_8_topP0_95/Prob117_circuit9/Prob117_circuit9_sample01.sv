
module TopModule (
  input clk,
  input a,
  output reg [2:0] q
);

  reg [2:0] next_q;

  always @(posedge clk) begin
    q <= next_q;
  end

  always @(*) begin
    next_q = q; // Default: maintain current value

    case (a)
      1'b1: begin
        if (q == 4'b000) begin
          next_q = 4'b001;
        end else if (q == 4'b001) begin
          next_q = 4'b010;
        end else if (q == 4'b010) begin
          next_q = 4'b011;
        end else if (q == 4'b011) begin
          next_q = 4'b100;
        end else if (q == 4'b100) begin
          next_q = 4'b000;
        end
      end

      1'b0: begin
        next_q = 4'b000; // Reset when a is 0
      end
    endcase
  end
endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
