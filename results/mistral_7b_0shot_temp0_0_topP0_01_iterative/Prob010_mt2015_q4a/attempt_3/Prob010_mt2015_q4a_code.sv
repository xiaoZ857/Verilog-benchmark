
module TopModule (
  input x,
  input y,
  output z
);
always @(posedge clk) begin
  if (init_z == 0) // Only assign new value when init_z is 0 (first clock cycle)
    z <= ((x ^ y) & x);
  else
    z <= init_z; // For subsequent clock cycles, keep the previous value of z
end

// Add clock input if not provided (assuming clk is positive edge triggered)
input clk;

// logic_value specifies the initial value of the output (0 or 1)
reg init_z = 0;
initial begin
  init_z = 0;
  forever #1 clk = ~clk; // rising edge every 1 time unit
end

assign z = init_z; // Assign the initial value to z before the always block

endmodule
