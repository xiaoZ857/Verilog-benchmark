
module TopModule (
  input clk,
  input areset,
  input train_valid,
  input train_taken,
  output logic [1:0] state
);
assign state = {train_taken & train_valid, ~areset & train_taken};

always @(posedge clk) begin
    if (areset)
        state <= 2'b00;
    else if (!~areset && areset == 0)
        state <= state;
    else if (!~areset && areset != 0 && train_valid && train_taken)
        state <= {state[1], ~state};
end

// VERILOG-EVAL: endmodule not found
