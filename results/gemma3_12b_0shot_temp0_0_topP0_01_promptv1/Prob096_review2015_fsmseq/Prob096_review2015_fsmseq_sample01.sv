
module TopModule (
  input clk,
  input reset,
  input data,
  output start_shifting
);
logic [3:0] state;
logic start_shifting_logic;

always @(posedge clk) begin
  if (reset) begin
    state <= 0;
    start_shifting_logic <= 0;
  end else begin
    case (state)
      0: begin
        if (data == 1)
          state <= 1;
        else
          state <= 0;
      end
      1: begin
        if (data == 1)
          state <= 2;
        else
          state <= 0;
      end
      2: begin
        if (data == 0)
          state <= 3;
        else
          state <= 0;
      end
      3: begin
        if (data == 1) begin
          state <= 0;
          start_shifting_logic <= 1;
        end else
          state <= 0;
      end
      default: state <= 0;
    endcase
  end
end

assign start_shifting = start_shifting_logic;
endmodule
