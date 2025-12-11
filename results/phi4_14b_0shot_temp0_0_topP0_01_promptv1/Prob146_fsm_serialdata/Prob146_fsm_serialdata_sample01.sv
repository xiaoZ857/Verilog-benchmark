
module TopModule (
  input clk,
  input in,
  input reset,
  output [7:0] out_byte,
  output done
);
logic [2:0] state, next_state;
logic [7:0] shift_reg;
logic [1:0] bit_count;

assign done = (state == 3'b100);

always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 3'b000;
        shift_reg <= 8'h00;
        bit_count <= 2'b00;
    end else begin
        state <= next_state;
        case (state)
            3'b000: begin
                if (!in) begin
                    shift_reg <= {7'b0, in};
                    bit_count <= 2'b01;
                end
            end
            3'b001: begin
                shift_reg <= {shift_reg[6:0], in};
                bit_count <= bit_count + 1'b1;
                if (bit_count == 2'b11) next_state = 3'b010;
            end
            3'b010: begin
                if (in) next_state = 3'b000; // Wait for stop bit
                else next_state = 3'b001; // Error, continue receiving bits
            end
        endcase
    end
end

assign out_byte = shift_reg;
