

module TopModule (
  input clk,
  input areset,
  input train_valid,
  input train_taken,
  output logic [1:0] state
);

always @(posedge clk or negedge areset)
begin
    if (areset) 
        state <= 2'b01;
    else if (train_valid && train_taken)
        state <= {state[1], state[0]+1};
    else if (train_valid && !train_taken)
        state <= {state[1], state[0]-1};
    else
        state <= state;
end

assign state = state;

// VERILOG-EVAL: endmodule not found
