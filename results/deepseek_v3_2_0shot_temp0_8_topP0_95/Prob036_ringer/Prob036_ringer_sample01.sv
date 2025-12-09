
module TopModule (
  input ring,
  input vibrate_mode,
  output ringer,
  output motor
);
  ringer = ring & ~vibrate_mode;
  motor = ring & vibrate_mode;
endmodule
