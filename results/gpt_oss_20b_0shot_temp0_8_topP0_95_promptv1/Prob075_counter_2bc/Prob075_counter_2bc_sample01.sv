
module TopModule (
  input clk,
  input areset,
  input train_valid,
  input train_taken,
  output logic [1:0] state
);
always @(posedge clk or posedge areset) begin
    if (areset)
        state <= 2'b01;
    else begin
        if (train_valid) begin
            if (train_taken) begin
                if (state < 2'b11)
                    state <= state + 1;
                else
                    state <= state;
            end else begin
                if (state > 2'b00)
                    state <= state - 1;
                else
                    state <= state;
            end
        end else begin
            state <= state;
        end
    end
end
endmodule
