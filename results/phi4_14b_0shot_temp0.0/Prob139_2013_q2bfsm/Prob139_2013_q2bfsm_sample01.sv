

module TopModule (
  input clk,
  input resetn,
  input x,
  input y,
  output f,
  output g
);

reg [2:0] state;
reg [1:0] x_counter;
reg g_reg;

always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        state <= 3'b000; // State A
        f <= 1'b0;
        g_reg <= 1'b0;
        x_counter <= 2'b00;
    end else begin
        case (state)
            3'b000: begin // State A
                f <= 1'b1;
                state <= 3'b001; // Transition to next state after setting f
            end

            3'b001: begin // State B
                f <= 1'b0;
                if (x == 1) begin
                    x_counter <= 2'b01;
                    state <= 3'b010;
                end else begin
                    x_counter <= 2'b00;
                end
            end

            3'b010: begin // State C
                if (x == 0) begin
                    x_counter <= 2'b11;
                    state <= 3'b011;
                end else begin
                    x_counter <= 2'b01;
                end
            end

            3'b011: begin // State D
                if (x == 1) begin
                    g_reg <= 1'b1; // Set g to 1
                    state <= 3'b100;
                end else begin
                    x_counter <= 2'b00;
                    state <= 3'b001;
                end
            end

            3'b100: begin // State E (g = 1)
                if (!g_reg) begin
                    g_reg <= 1'b1; // Maintain g = 1 until reset
                end else if (y == 1) begin
                    state <= 3'b101; // Transition to permanent g = 1
                end else if (x_counter == 2'b10) begin
                    g_reg <= 1'b0; // Set g to 0 permanently
                    state <= 3'b001;
                end else begin
                    x_counter <= x_counter + 1'b1;
                end
            end

            3'b101: begin // State F (permanent g = 1)
                g_reg <= 1'b1; // Maintain g = 1 permanently
            end

            default: state <= 3'b000;
        endcase
    end
end

assign f = (state == 3'b001) ? 1'b1 : 1'b0;
assign g = g_reg;

endmodule
