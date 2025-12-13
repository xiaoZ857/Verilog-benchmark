
module TopModule (
  input cpu_overheated,
  output reg shut_off_computer,
  input arrived,
  input gas_tank_empty,
  output reg keep_driving
);
      always @(*) begin
          if (~arrived) 
              keep_driving = ~gas_tank_empty;
          else 
              keep_driving = 0;
      end

// VERILOG-EVAL: endmodule not found
