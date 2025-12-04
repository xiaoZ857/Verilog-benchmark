
module TopModule (
  input clk,
  input resetn,
  input x,
  input y,
  output f,
  output g
);
  // State encoding
  localparam A     = 3'd0;
  localparam B     = 3'd1;
  localparam C     = 3'd2;
  localparam D1    = 3'd3;
  localparam D2    = 3'd4;
  localparam G_HOLD = 3'd5;
  localparam G_OFF  = 3'd6;

  reg [2:0] state, next_state;
  reg [2:0] x_shift;  // shift register to store last 3 values of x
  reg f_reg, g_reg;

  // Sequential state and shift register update
  always @(posedge clk) begin
    if (!resetn) begin
      state <= A;
      x_shift <= 3'b0;
    end else begin
      state <= next_state;
      x_shift <= {x_shift[1:0], x};  // shift in new x
    end
  end

  // FSM next-state logic
  always @(*) begin
    case (state)
      A: next_state = resetn ? B : A;  // Wait for reset deassertion
      B: next_state = C;               // f=1 for one cycle, then go to C
      C: begin
        // Check if last 3 values of x are 1,0,1
        if (x_shift == 3'b101)
          next_state = D1;
        else
          next_state = C;
      end
      D1: begin
        if (y)
          next_state = G_HOLD;
        else
          next_state = D2;
      end
      D2: begin
        if (y)
          next_state = G_HOLD;
        else
          next_state = G_OFF;
      end
      G_HOLD: next_state = G_HOLD;  // Permanent until reset
      G_OFF:  next_state = G_OFF;   // Permanent until reset
      default: next_state = A;
    endcase
  end

  // Output logic
  always @(posedge clk) begin
    if (!resetn) begin
      f_reg <= 0;
      g_reg <= 0;
    end else begin
      // f = 1 only in state B
      f_reg <= (next_state == B);

      // g = 1 in states D1, D2, G_HOLD
      case (next_state)
        D1, D2, G_HOLD: g_reg <= 1;
        G_OFF:          g_reg <= 0;
        default:        g_reg <= g_reg;  // hold previous value in other states
      endcase
    end
  end

  assign f = f_reg;
  assign g = g_reg;
endmodule
