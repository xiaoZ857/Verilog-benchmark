
module TopModule (
  input clk,
  input resetn,
  input x,
  input y,
  output f,
  output g
);
  // State definitions
  localparam A = 3'd0,
             B = 3'd1,
             C = 3'd2,
             D = 3'd3,
             E = 3'd4,
             F = 3'd5;
  
  reg [2:0] state, next_state;
  reg [1:0] x_history;  // Stores last two x values
  reg [1:0] y_counter;  // Counts cycles in state D
  reg f_reg, g_reg;
  
  // State register (synchronous reset)
  always @(posedge clk) begin
    if (!resetn)
      state <= A;
    else
      state <= next_state;
  end
  
  // Next state logic
  always @(*) begin
    case (state)
      A: next_state = (!resetn) ? A : B;  // Stay in A while reset is active
      B: next_state = C;  // Move to C after one cycle in B
      C: begin
        // Check for pattern 1,0,1 in x_history[1:0] and current x
        // x_history[1] is oldest (two cycles ago), x_history[0] is previous cycle
        if (x_history == 2'b10 && x == 1'b1)
          next_state = D;
        else
          next_state = C;
      end
      D: begin
        if (y == 1'b1)
          next_state = E;
        else if (y_counter == 2'd0)
          next_state = F;
        else
          next_state = D;
      end
      E: next_state = E;  // Permanent g=1 state
      F: next_state = F;  // Permanent g=0 state
      default: next_state = A;
    endcase
  end
  
  // x history shift register - track last two x values in state C
  always @(posedge clk) begin
    if (!resetn)
      x_history <= 2'b00;
    else if (state == C)
      x_history <= {x_history[0], x};
    else
      x_history <= 2'b00;
  end
  
  // y counter (counts down from 2 in state D)
  always @(posedge clk) begin
    if (!resetn)
      y_counter <= 2'd2;
    else if (state == D) begin
      if (y_counter != 2'd0)
        y_counter <= y_counter - 1'b1;
    end else
      y_counter <= 2'd2;
  end
  
  // Output logic (registered outputs)
  always @(posedge clk) begin
    if (!resetn) begin
      f_reg <= 1'b0;
      g_reg <= 1'b0;
    end else begin
      // Default outputs
      f_reg <= 1'b0;
      g_reg <= 1'b0;
      
      case (state)
        A: begin
          f_reg <= 1'b0;
          g_reg <= 1'b0;
        end
        B: begin
          f_reg <= 1'b1;  // f=1 for one cycle after reset deassertion
          g_reg <= 1'b0;
        end
        C: begin
          f_reg <= 1'b0;
          g_reg <= 1'b0;
        end
        D: begin
          f_reg <= 1'b0;
          g_reg <= 1'b1;  // g=1 while in state D
        end
        E: begin
          f_reg <= 1'b0;
          g_reg <= 1'b1;  // Permanent g=1
        end
        F: begin
          f_reg <= 1'b0;
          g_reg <= 1'b0;  // Permanent g=0
        end
        default: begin
          f_reg <= 1'b0;
          g_reg <= 1'b0;
        end
      endcase
    end
  end
  
  assign f = f_reg;
  assign g = g_reg;
endmodule
