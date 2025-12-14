
module TopModule (
  input clk,
  input [7:0] in,
  input reset,
  output done
);
reg [2:0] current_byte;
reg state = 0; // 0: idle, 1: waiting for message start, 2: receiving message

always @(posedge clk) begin
  if (reset) begin
    current_byte <= 3'b000;
    state <= 0;
  end else if (state == 0 && in[3]) begin // Waiting for message start
    current_byte <= in;
    state <= 1;
  end else if (state == 1) begin // Receiving message
    current_byte <= {current_byte[1:0], in};
    if (current_byte[2] == in[3]) begin
      state <= 2; // Message received, wait for next message start
    end
  end else if (state == 2 && current_byte[2] == in[3]) begin // Waiting for message end
    done <= 1'b1; // Signal done immediately after the third byte
    state <= 0; // Reset FSM to wait for next message start
  end
end

assign done = ~state && (current_byte == 3'b011 || current_byte == 3'b110);

// Include the following line if you want to use the IEEE Std 1364-2001 compliant edge-sensitive reset
initial always @(posedge clk or negedge reset) begin
  if (reset) begin
    current_byte <= 3'b000;
    state <= 0;
  end
end

// VERILOG-EVAL: endmodule not found
