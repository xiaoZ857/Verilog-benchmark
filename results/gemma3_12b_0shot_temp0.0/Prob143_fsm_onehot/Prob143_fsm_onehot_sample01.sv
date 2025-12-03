

module TopModule (
  input in,
  input [9:0] state,
  output [9:0] next_state,
  output out1,
  output out2
);

  always @(posedge clk) begin
    case (state)
      9'b000000000: begin
        if (in == 0) begin
          next_state = 9'b000000000;
        end else begin
          next_state = 9'b000000001;
        end
      end
      9'b000000001: begin
        if (in == 0) begin
          next_state = 9'b000000000;
        end else begin
          next_state = 9'b000000010;
        end
      end
      9'b000000010: begin
        if (in == 0) begin
          next_state = 9'b000000000;
        end else begin
          next_state = 9'b000000011;
        end
      end
      9'b000000011: begin
        if (in == 0) begin
          next_state = 9'b000000000;
        end else begin
          next_state = 9'b000000100;
        end
      end
      9'b000000100: begin
        if (in == 0) begin
          next_state = 9'b000000000;
        end else begin
          next_state = 9'b000000101;
        end
      end
      9'b000000101: begin
        if (in == 0) begin
          next_state = 9'b000000000;
        end else begin
          next_state = 9'b000001000;
        end
      end
      9'b000001000: begin
        if (in == 0) begin
          next_state = 9'b000000000;
        end else begin
          next_state = 9'b000001001;
        end
      end
      9'b000001001: begin
        if (in == 0) begin
          next_state = 9'b000000000;
        end else begin
          next_state = 9'b000010000;
        end
      end
      9'b000010000: begin
        if (in == 0) begin
          next_state = 9'b000000000;
        end else begin
          next_state = 9'b000010001;
        end
      end
      9'b000010001: begin
        if (in == 0) begin
          next_state = 9'b000000000;
        end else begin
          next_state = 9'b000100000;
        end
      end
      default: begin
        next_state = 9'b000000000;
      end
    endcase
  end

  assign out1 = (state == 9'b000000011) ? 1 : 0;
  assign out2 = (state == 9'b000000101) ? 1 : 0;
endmodule
