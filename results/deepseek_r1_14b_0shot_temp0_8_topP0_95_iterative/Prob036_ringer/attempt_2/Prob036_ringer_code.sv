
$timescale 1ns / 1ps

module TopModule (
  input ring,
  input vibrate_mode,
  output ringer,
  output motor
);

assign ringer = !vibrate_mode & ring;
assign motor = vibrate_mode;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
