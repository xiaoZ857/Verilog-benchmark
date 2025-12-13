
module TopModule (
  input clk,
  input areset,
  input x,
  output z
);

  typedef enum {
    START,
    WAIT_DATA,
    READ_DATA,
    PROCESS_DATA,
    STOP
  ) StateType;

  reg [31:0] result;
  reg [31:0] bit_count;
  reg state, next_state;
  wire input_valid;

  always @(posedge clk or areset) begin
    if (areset) begin
      state <= START;
      result <= 0;
      bit_count <= 0;
    end else begin
      state <= next_state;
    end
  end

  always @(*) begin
    case (state)
      START:
        if (input_valid) begin
          next_state = READ_DATA;
        end else begin
          next_state = START;
        end
      WAIT_DATA:
        if (x == 1) begin
          next_state = PROCESS_DATA;
        end else begin
          next_state = WAIT_DATA;
        end
      READ_DATA:
        begin
          result <= x << bit_count;
          next_state = WAIT_DATA;
          bit_count <= bit_count + 1;
        end
      PROCESS_DATA:
        if (bit_count == 31) begin
          next_state = STOP;
        end else begin
          next_state = READ_DATA;
        end
      default:
        next_state = START;
    endcase
  end

  assign z = result;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
