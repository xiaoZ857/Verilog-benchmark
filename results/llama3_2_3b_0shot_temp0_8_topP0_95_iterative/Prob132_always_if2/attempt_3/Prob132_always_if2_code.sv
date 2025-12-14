
module TopModule (
  input cpu_overheated,
  output reg shut_off_computer,
  input arrived,
  input gas_tank_empty,
  output reg keep_driving
);
always @(*) begin
    if (cpu_overheated)
        shut_off_computer = 1'b0;  // Active low
    
    else
        if (~arrived && ~gas_tank_empty)
            keep_driving = 1'b1;
        else 
            shut_off_computer = 0;  // Active high
            keep_driving = 0;      // Active low
end

endmodule
