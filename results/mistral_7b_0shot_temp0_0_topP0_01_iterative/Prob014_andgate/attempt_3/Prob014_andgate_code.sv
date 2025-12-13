
module TopModule (
  input a,
  input b,
  output out
);
wire out;

always @(posedge clk) begin
  if (a && b)
    out = 1;
  else
    out = 0;
end

// Add a global clock declaration to make it accessible within the always block
reg clk;

initial begin
  out = 0; // Initialization of the output signal
  clk = 0; // Clock initial value and reset
  #5 clk = !clk; // Clock toggles every 5 time units
end

assign out (TopModule.out);

endmodule
