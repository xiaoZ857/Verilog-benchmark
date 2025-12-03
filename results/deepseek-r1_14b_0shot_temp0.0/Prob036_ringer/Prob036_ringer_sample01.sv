

module TopModule (
  input ring,
  input vibrate_mode,
  output ringer,
  output motor
);

ringer = (ring == 1) ? (~vibrate_mode) : 0;
motor = (ring == 1) ? vibrate_mode : 0;

endmodule
