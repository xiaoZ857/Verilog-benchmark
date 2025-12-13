
module TopModule (
  input clk,
  input resetn,
  input x,
  input y,
  output f,
  output g
);
reg state; // FSM state variable
reg last_x; // Last value of the x input
reg last_last_x; // Two clock cycles ago value of the x input
reg last_y; // Last value of the y input
reg f; // Output controlling motor
reg g; // Output controlling motor

always @(posedge clk or posedge resetn) begin
  if (resetn) begin
    state <= 0; // Reset to initial state A
    f <= 0; // Set f to 0 when reset is asserted
    g <= 0; // Set g to 0 when reset is asserted
  end else begin
    case(state)
      0: begin // Initial state A
        if (~last_x && x) begin
          state <= 1; // Transition to next state
          f <= 1; // Set f to 1 for one clock cycle
        end
      1: begin // Monitoring x input
        last_last_x <= last_x;
        last_x <= x;
        if (last_last_x && last_x && x) begin
          state <= 2; // Transition to next state when condition met
        end
      2: begin // Monitoring y input
        last_y <= y;
        if (y) begin
          g <= 1; // Set g to 1 if y becomes 1 within two clock cycles
        end else if ((last_y == 0) && (clk > 2)) begin
          g <= clk > 3 ? 0 : g; // Set g to 0 if y does not become 1 within two clock cycles
        end
      end
    endcase
  end
end

// Add any necessary initializations for the module here
initial begin
  state = 0;
  last_x = 0;
  last_last_x = 0;
  last_y = 0;
  f = 0;
  g = 0;
end

endmodule
