
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output reg q
);

always @(posedge clk) begin
  if((a && !b) || (c && d))
    q <= 1'b0;
  else
    q <= 1'b1;
end

initial begin
  clk = 0; // Initial clock state
  #5 clk = 1; // Clock pulse with 5ns period
  repeat(12) begin // Repeat the clock pulse for 60ns (total simulation time is 90ns)
    #40 clk = !clk;
  end
end

initial begin
  $display("Time\ta\tb\tc\td\tq"); // Print time and signal values for waveform visualization
  $write("\n");
  foreach(i=0; i<13; i=i+1) begin
    #5 $display("%dns", i);
    $write(" ");
    $display("%b", a);
    $write(" ");
    $display("%b", b);
    $write(" ");
    $display("%b", c);
    $write(" ");
    $display("%b", d);
    $write(" ");
    $display("%b", q);
    $write("\n");
  end
end

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
