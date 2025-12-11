
module TopModule (
  input ring,
  input vibrate_mode,
  output ringer,
  output motor
);
assign ringer = !vibrate_mode & ring;
assign motor = vibrate_mode | (!vibrate_mode & ring);
endmodule
