

module TopModule (
  input clk,
  input [7:0] in,
  input reset,
  output done
);

reg [1:0] state;
reg [2:0] byte_count;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 2'b00; // Initial state
        byte_count <= 3'b000;
    end else begin
        case (state)
            2'b00: begin // Waiting for the first byte of a message
                if (in[3] == 1'b1) begin
                    state <= 2'b01;
                    byte_count <= 3'b001; // First byte received
                end
            end

            2'b01: begin // Receiving second or third byte
                byte_count <= byte_count + 1'b1;
                if (byte_count == 3'b011) begin
                    state <= 2'b10; // All three bytes received
                end
            end

            2'b10: begin // Waiting for the next message start
                if (in[3] == 1'b1) begin
                    byte_count <= 3'b001; // Reset to first byte of new message
                    state <= 2'b01;
                end else begin
                    state <= 2'b00; // Continue waiting for a new message
                end
            end

            default: state <= 2'b00;
        endcase
    end
end

assign done = (state == 2'b10) ? 1'b1 : 1'b0;

endmodule
