
module TopModule (
  input clock,
  input a,
  output reg p,
  output reg q
);
  reg [1:0] state;

  always @(posedge clock) begin
    if (clock == 0) begin
      state <= state;
    end else begin
      if (a == 0) begin
        state <= 2'b00;
      end else begin
        state <= 2'b01;
      end
    end
  end

  always @(posedge clock) begin
    case (state)
      2'b00: begin
        p <= 0;
        q <= 0;
      end
      2'b01: begin
        if (a == 0) begin
          p <= 0;
          q <= 0;
        end else begin
          p <= 0;
          q <= 0;
        end
      end
      2'b10: begin
        p <= 0;
        q <= 0;
      end
      2'b11: begin
        p <= 0;
        q <= 0;
      end
      default: begin
        p <= 0;
        q <= 0;
      end
    endcase
    if (clock == 1) begin
      if (a == 0) begin
        if (state == 2'b00) begin
          q <= 0;
        end else if (state == 2'b01) begin
          q <= 0;
        end
      end else begin
        if (state == 2'b00) begin
          q <= 0;
        end else if (state == 2'b01) begin
          q <= 0;
        end
      end
    end
    if (clock == 1) begin
      if (a == 1) begin
        if (state == 2'b00) begin
          p <= 0;
        end else if (state == 2'b01) begin
          p <= 0;
        end
      end else begin
        if (state == 2'b00) begin
          p <= 0;
        end else if (state == 2'b01) begin
          p <= 0;
        end
      end
    end
  end
endmodule
