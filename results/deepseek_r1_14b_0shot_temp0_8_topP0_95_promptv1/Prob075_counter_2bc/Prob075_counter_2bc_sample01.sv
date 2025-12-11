
module TopModule (
  input clk,
  input areset,
  input train_valid,
  input train_taken,
  output logic [1:0] state
);
always @(posedge clk) begin
    if (areset)
        state <= 2'b01;
    else if (train_valid) begin
        if (train_taken) begin
            if (state == 3)
                state <= 3;
            else
                state <= state + 1;
        end else begin
            if (state == 0)
                state <= 0;
            else
                state <= state - 1;
        end
    end
end
endmodule
