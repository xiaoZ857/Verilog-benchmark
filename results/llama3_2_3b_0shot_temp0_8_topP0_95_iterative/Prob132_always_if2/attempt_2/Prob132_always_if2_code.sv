
module TopModule (
  input cpu_overheated,
  output reg shut_off_computer,
  input arrived,
  input gas_tank_empty,
  output reg keep_driving
);
// Always block to implement the logic
always @(*) begin
    // If CPU is overheated, shut off the computer
    if (cpu_overheated)
        shut_off_computer = 1'b0;  // Active low
    
    // If car arrived at gas station and gas tank is empty, keep driving
    else if (~arrived && ~gas_tank_empty)
        keep_driving = 1'b1;
    
    // Otherwise, don't change the values of shut_off_computer or keep_driving
    else 
        shut_off_computer = 0;  // Active high
        keep_driving = 0;      // Active low
end

// End of module body (you can remove these two lines if they are not needed)
// endmodule

// VERILOG-EVAL: endmodule not found
