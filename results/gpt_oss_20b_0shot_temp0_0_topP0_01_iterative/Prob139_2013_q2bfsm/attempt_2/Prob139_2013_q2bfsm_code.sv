
module TopModule (
  input clk,
  input resetn,
  input x,
  input y,
  output f,
  output g
);
  // State encoding
  localparam STATE_A      = 3'd0;  // Initial state (reset asserted)
  localparam STATE_SET_F  = 3'd1;  // Set f = 1 for one cycle
  localparam STATE_MON_X  = 3'd2;  // Monitor x for pattern 1,0,1
  localparam STATE_SET_G  = 3'd3;  // Set g = 1 for one cycle
  localparam STATE_MON_Y  = 3'd4;  // Monitor y for up to two cycles
  localparam STATE_G_ON   = 3'd5;  // g = 1 permanently
  localparam STATE_G_OFF  = 3'd6;  // g = 0 permanently

  reg [2:0] state, next_state;
  reg f, g;
  reg [2:0] x_shift;          // Shift register for last three x values
  reg [1:0] y_cnt;            // Counter for monitoring y (0..2)

  // Sequential logic: state register, outputs, and shift register
  always @(posedge clk) begin
    if (!resetn) begin
      state   <= STATE_A;
      f       <= 1'b0;
      g       <= 1'b0;
      x_shift <= 3'b000;
      y_cnt   <= 2'b00;
    end else begin
      state   <= next_state;

      // Output logic
      case (state)
        STATE_SET_F: f <= 1'b1;
        default:     f <= 1'b0;
      endcase

      case (state)
        STATE_SET_G: g <= 1'b1;
        STATE_G_ON:  g <= 1'b1;
        default:     g <= 1'b0;
      endcase

      // Shift register for x
      if (state == STATE_MON_X || state == STATE_SET_G || state == STATE_MON_Y) begin
        x_shift <= {x_shift[1:0], x};
      end else begin
        x_shift <= 3'b000;
      end

      // y counter
      if (state == STATE_MON_Y) begin
        if (y_cnt < 2)
          y_cnt <= y_cnt + 1;
      end else begin
        y_cnt <= 2'b00;
      end
    end
  end

  // Combinational logic: next state
  always @(*) begin
    case (state)
      STATE_A: begin
        if (resetn)          // reset deasserted
          next_state = STATE_SET_F;
        else

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
