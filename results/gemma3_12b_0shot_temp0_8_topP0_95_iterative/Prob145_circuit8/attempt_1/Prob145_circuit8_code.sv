
module TopModule (
  input clock,
  input a,
  output reg p,
  output reg q
);

  reg [1:0] state;

  always @(posedge clock) begin
    case (state)
      2'b00: begin
        if (a == 0) begin
          p <= 0;
          q <= 0;
        end else begin
          p <= 0;
          q <= 1;
        end
      end
      2'b01: begin
        p <= 0;
        q <= 0;
      end
      2'b10: begin
        if (a == 0) begin
          p <= 0;
          q <= 0;
        end else begin
          p <= 0;
          q <= 1;
        end
      end
      2'b11: begin
        p <= 0;
        q <= 1;
      end
      default: begin
        p <= 0;
        q <= 0;
      end
    endcase
  end

  always @(posedge clock) begin
    if (clock == 0) begin
      state <= 2'b00;
    end else if (a == 0) begin
      state <= 2'b01;
    end else begin
      state <= 2'b10;
    end
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
