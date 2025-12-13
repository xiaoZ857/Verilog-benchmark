
module TopModule (
  input [6:1] y,
  input w,
  output Y2,
  output Y4
);
always @(*) begin
    // Default values for next state signals
    Y2 = 0;
    Y4 = 0;

    // Logic for Y2 and Y4 based on current state and input
    if (y[1] && ~w) begin
        Y2 = 1; // Transition A to B or B to C
    end

    if ((y[2] && ~w) || (y[3] && w) || (y[4] && ~w) || (y[5] && w)) begin
        Y4 = 1; // Transitions B to D, C to E, D to F, E to D, or F to C
    end
end

endmodule
