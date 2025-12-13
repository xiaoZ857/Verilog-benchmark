
module TopModule (
  input x,
  input y,
  output z
);
always @(posedge clk) begin
    if(x == 1 && y == 1) state = 3'b001;
    else if(x == 0 && y == 0) state = 3'b000;
    else if(x == 1 && y == 0) state = 3'b011;
    else if(x == 0 && y == 1) state = 3'b010;

    // Check if either x or y has changed from its previous value
    if((x != x_prev || y != y_prev)) z <= 1; // Set z to 1 when either x or y changes
    else z <= z_prev; // Otherwise, keep the same value as before

    // Update previous values for x and y
    x_prev <= x;
    y_prev <= y;
end

// VERILOG-EVAL: endmodule not found
