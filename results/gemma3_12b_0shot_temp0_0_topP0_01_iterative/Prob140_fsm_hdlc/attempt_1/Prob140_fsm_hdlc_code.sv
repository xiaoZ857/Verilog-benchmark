
module TopModule (
  input clk,
  input reset,
  input in,
  output disc,
  output flag,
  output err
);

  // Define states
  parameter IDLE = 2'b00;
  parameter ONE = 2'b01;
  parameter TWO = 2'b10;
  parameter THREE = 2'b11;

  reg [1:0] current_state;
  reg [1:0] next_state;

  // Output registers
  reg disc_reg;
  reg flag_reg;
  reg err_reg;

  // Output signals
  assign disc = disc_reg;
  assign flag = flag_reg;
  assign err = err_reg;

  // State register update
  always @(posedge clk) begin
    if (reset) begin
      current_state <= IDLE;
      disc_reg <= 0;
      flag_reg <= 0;
      err_reg <= 0;
    end else begin
      current_state <= next_state;
      disc_reg <= 0;
      flag_reg <= 0;
      err_reg <= 0;
    end
  end

  // Next state logic and output generation
  always @(*) begin
    next_state = current_state; // Default: stay in the current state

    case (current_state)
      IDLE: begin
        if (in) begin
          next_state = ONE;
        end
      end
      ONE: begin
        if (in) begin
          next_state = TWO;
        end else begin
          next_state = IDLE;
        end
      end
      TWO: begin
        if (in) begin
          next_state = THREE;
        end else begin
          next_state = IDLE;
        end
      end
      THREE: begin
        if (in) begin
          next_state = current_state; // Stay in THREE
          if (current_state == ONE) begin
            disc_reg = 1;
          end
        end else begin
          next_state = IDLE;
        end
      end
      default: begin
        next_state = IDLE;
      end
    endcase

    // Flag detection (01111110)
    if (current_state == THREE && in == 0) begin
      flag_reg = 1;
    end

    // Error detection (7 or more consecutive 1s)
    if (current_state == THREE && in == 1) begin
      err_reg = 1;
    end
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
