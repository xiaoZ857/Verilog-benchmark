
module TopModule (
  input clk,
  input resetn,
  input x,
  input y,
  output f,
  output g
);
always @(posedge clk) begin
    if (!resetn) begin
        f <= 1'b0;
        g <= 1'b0;
        state <= A;
        x_history <= 3'b000;
        y_counter <= 2'b00;
    end else begin
        case (state)
            A: begin
                f <= 1'b1;
                state <= B;
                x_history <= 3'b000;
                y_counter <= 2'b00;
            end
            B: begin
                f <= 1'b0;
                x_history <= {x_history[1:0], x};
                if (x_history == 3'b101) begin
                    g <= 1'b1;
                    state <= C;
                    y_counter <= 2'b00;
                end
            end
            C: begin
                if (y) begin
                    state <= D;
                end else if (y_counter == 2'b01) begin
                    g <= 1'b0;
                    state <= E;
                end else begin
                    y_counter <= y_counter + 1;
                end
            end
            D: begin
            end
            E: begin
            end
        endcase
    end
end

localparam A = 3'd0, B = 3'd1, C = 3'd2, D = 3'd3, E = 3'd4;
reg [2:0] state;
reg [2:0] x_history;
reg [1:0] y_counter;

endmodule
