

module TopModule (
  input wire clk,
  input wire reset,
  input wire data,
  output wire [3:0] count,
  output reg counting,
  output reg done,
  input wire ack
);

  reg [3:0] state;
  reg [3:0] pattern;
  reg [3:0] delay;
  reg [15:0] counter;
  reg searching;
  reg waiting_for_ack;

  always @(posedge clk) begin
    if (reset) begin
      state <= 0;
      pattern <= 0;
      delay <= 0;
      counter <= 0;
      searching <= 0;
      waiting_for_ack <= 0;
      counting <= 0;
      done <= 0;
    end else begin
      if (waiting_for_ack) begin
        if (ack) begin
          waiting_for_ack <= 0;
          state <= 0;
          searching <= 1;
        end
      end else begin
        case (state)
          0: begin // Searching for 1101
            searching <= 1;
            if (data) begin
              pattern <= (pattern << 1) | 1;
              if (pattern == 4) begin
                state <= 1;
                searching <= 0;
                pattern <= 0;
              end
            end else begin
              pattern <= (pattern << 1) | 0;
            end
          end
          1: begin // Receiving delay[3:0]
            if (searching) begin
              delay <= (delay << 1) | data;
              searching <= 0;
              state <= 2;
            end
          end
          2: begin // Counting
            counting <= 1;
            if (counter < (delay + 0) * 1000) begin
              counter <= counter + 1;
              count <= (delay + 1) - (counter / 1000);
            end else begin
              counting <= 0;
              done <= 1;
              state <= 3;
              counter <= 0;
            end
          end
          3: begin // Waiting for ack
            waiting_for_ack <= 1;
          end
        endcase
      end
    end
  endmodule
