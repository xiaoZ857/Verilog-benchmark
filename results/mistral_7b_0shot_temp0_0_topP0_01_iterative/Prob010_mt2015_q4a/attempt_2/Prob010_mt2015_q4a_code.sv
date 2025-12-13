
module TopModule (
  input x,
  input y,
  output z
);
always @(posedge clk) begin
  z <= ((x ^ y) & x);
end

// Add clock input if not provided (assuming clk is positive edge triggered)
input clk;

// logic_value specifies the initial value of the output (0 or 1)
reg init_z = 0;
initial begin
  init_z = 0;
  forever #1 clk = ~clk; // rising edge every 1 time unit
  z <= init_z;
end

assign z = init_z; // Assign the initial value to z before the always block

endmodule
