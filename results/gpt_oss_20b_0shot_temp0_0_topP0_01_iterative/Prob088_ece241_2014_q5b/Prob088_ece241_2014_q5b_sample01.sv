
module TopModule (
  input clk,
  input areset,
  input x,
  output z
);
// State register (one‑hot encoding: A = 2'b01, B = 2'b10)
reg [1:0] state, next_state;

// Asynchronous reset and synchronous state update
always @(posedge clk or posedge areset) begin
    if (areset)
        state <= 2'b01;          // reset to state A
    else
        state <= next_state;     // update to next state
end

// Next‑state logic (Mealy machine)
always @(*) begin
    case (state)
        2'b01: begin // State A
            if (x)
                next_state = 2

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
