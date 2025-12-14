
module TopModule (
  input clk,
  input w,
  input R,
  input E,
  input L,
  output reg Q
);
reg [n-1:0] prev_stage; // assuming n-bit shift register

// We need to specify a timescale here or in another module that uses this module.
// Here, we're using a 10ns clock period for simplicity.
timescale 1 ns / 10;

always @(posedge clk) begin
    if(E == 0 && L == 0) begin // no change or load on this clock cycle
        Q <= w; // assign w to Q
    else if (E == 1 && L == 0) begin // enable shift and not loading
        prev_stage <= w; // save the current stage's value in prev_stage
        if (prev_stage[0] == 1) then // check if the least significant bit is set
            Q <= {prev_stage[2:n-1], 0}; // new state is the next two bits of prev_stage shifted left by one position, followed by 0 (first two positions)
        else
            Q <= {prev_stage[2:n-1], w}; // new state is the next two bits of prev_stage shifted left by one position, followed by w (first two positions)
    else if(E == 1 && L == 1) begin // enable shift and loading
        Q <= R; // assign value of R to Q
    end
end

// Default value for Q when no clock edge has occurred
always @(*) begin
    if (!L) begin
        Q <= {w, prev_stage[2:n-1]}; // initial state is the first two bits of prev_stage followed by w
    else
        Q <= R; // assign value of R to Q when L is high and E is low
end

endmodule
