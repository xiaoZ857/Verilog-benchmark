
module TopModule (
  input ring,
  input vibrate_mode,
  output ringer,
  output motor
);
begin
    // If vibrate mode is true, then ring should be 1. Otherwise, turn on the ringer if ring is 1
    if (vibrate_mode) {
        motor = 0;
        ringer = 1; 
    } else if (ring == 1) {  // Corrected the syntax error here
        ringer = 1;
        motor = 0;
    } else if (ring == 0 && vibrate_mode == 0){
        ringer = 0;
        motor = 0;  
    }
endmodule
