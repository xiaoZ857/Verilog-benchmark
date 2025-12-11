
module TopModule (
  input clk,
  input reset,
  input w,
  output z
);
logic state;
logic next_state;

always_ff @(posedge clk) begin
    if (reset) begin
        state <= 0;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        0: begin
            if (w)
                next_state = 1;
            else
                next_state = 0;
        end
        1: begin
            if (w)
                next_state = 2;
            else
                next_state = 3;
        end
        2: begin
            if (w)
                next_state = 4;
            else
                next_state = 3;
        end
        3: begin
            if (w)
                next_state = 5;
            else
                next_state = 0;
        end
        4: begin
            if (w)
                next_state = 5;
            else
                next_state = 3;
        end
        5: begin
            if (w)
                next_state = 2;
            else
                next_state = 3;
        end
        default: next_state = 0;
    endcase
end

assign z = state == 5;

endmodule
