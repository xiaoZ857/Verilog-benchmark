
module TopModule (
  input clk,
  input d,
  input ar,
  output logic q
);
always @(posedge clk or negedge ar) // Always block triggers on positive edge of clk and any change on ar
begin
  if (~ar) // If reset signal is low, set the flip-flop to 0
    q <= 0;
  else if (d) // If data input and reset are both high, set the flip-flop to 1
    q <= 1;
end

always @(posedge clk)
begin
  if (!~ar) // To prevent setting 'q' when 'ar' is low
    q <= d;
end

assign output q; // Assign output to internal register

endmodule
