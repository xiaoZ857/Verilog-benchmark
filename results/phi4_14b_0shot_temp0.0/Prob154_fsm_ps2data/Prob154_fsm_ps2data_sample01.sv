

module TopModule (
  input clk,
  input [7:0] in,
  input reset,
  output [23:0] out_bytes,
  output done
);

reg [2:0] state;
reg [2:0] byte_count;
reg [23:0] message_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= 3'b000; // Initial state, waiting for start of message
        byte_count <= 3'b000;
        message_reg <= 24'b0;
    end else begin
        case (state)
            3'b000: begin // Waiting for the first byte with in[3] = 1
                if (in[3]) begin
                    state <= 3'b001; // Move to next state, expecting second byte
                    message_reg[23:16] <= in;
                    byte_count <= 3'b001;
                end
            end
            3'b001: begin // Expecting the second byte
                message_reg[15:8] <= in;
                byte_count <= byte_count + 1'b1;
                state <= 3'b010; // Move to next state, expecting third byte
            end
            3'b010: begin // Expecting the third byte
                message_reg[7:0] <= in;
                byte_count <= byte_count + 1'b1;
                if (byte_count == 3'b011) begin
                    state <= 3'b000; // Reset to initial state after full message received
                end
            end
        endcase
    end
end

assign done = (state == 3'b010 && byte_count == 3'b011);
assign out_bytes = (done) ? message_reg : 24'bx;

endmodule
