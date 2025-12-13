
module TopModule (
  input [5:0] y,
  input w,
  output Y1,
  output Y3
);
always @(posedge clk) begin
  if (Y1) begin
    case ({Y1, Y3})
      2'b00: Y1 <= 0;
      2'b01: Y1 <= 1;
      2'b10: Y1 <= 0; // A state

      2'b11: if (Y3) begin
                Y3 <= 0;
              end else begin
                Y3 <= 1;
              end; // B state
    end

    case ({Y1, ~Y3})
      2'b00: Y1 <= 0;
      2'b01: Y1 <= 0;
      2'b10: Y1 <= 0; // A state

      2'b11: if (w) begin
                Y3 <= 0;
              end else begin
                Y3 <= 1;
              end; // D state

    case ({Y3})
      // Remove the direct combinational loop by adding a condition to prevent Y1 from depending on itself
      if (Y1 != 1'b1) begin
        case ({Y1})
          2'b0: begin
            if (Y3) begin
              case ({Y1})
                2'b0: Y1 <= 1; // C state
                2'b1: Y1 <= 0; // D state
              end
            end else begin
              case ({Y1})
                2'b0: Y1 <= 0; // A state
                2'b1: Y1 <= 1; // B state
              end
            end
          end
        end
    end

    case ({~Y3})
      // Remove the direct combinational loop by adding a condition to prevent Y1 from depending on itself
      if (Y1 != 1'b0) begin
        if (w) begin
          case ({Y1})
            2'b0: Y1 <= 1; // E state
            2'b1: Y1 <= 0; // D state
          end
        end else begin
          case ({Y1})
            2'b0: Y1 <= 0; // A state
            2'b1: Y1 <= 1; // B state
          end
        end
      end
    endcase

    case ({Y1, ~w})
      2'b00: Y1 <= 1; // F state
      2'b01: Y1 <= 0; // D state
    endcase
  end
end

// Add a reset signal to the Y1 flip-flop
reg [5:0] y_reset = {6'b000000, 6'b000001}; // Reset value for one-hot encoded states
always @(posedge clk or negedge reset) begin
  if (reset)
    Y1 <= y_reset[1];
end

// Add a reset signal to the Y3 flip-flop
reg [5:0] y3_reset = {6'b000100, 6'b001000}; // Reset value for one-hot encoded states
always @(posedge clk or negedge reset) begin
  if (reset)
    Y3 <= y3_reset[3];
end

endmodule
