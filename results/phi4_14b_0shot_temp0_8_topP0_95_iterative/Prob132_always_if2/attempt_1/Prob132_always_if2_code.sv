
module TopModule (
  input cpu_overheated,
  output reg shut_off_computer,
  input arrived,
  input gas_tank_empty,
  output reg keep_driving
);
module top_module (
    input      clk,             // Clock signal
    input      reset,           // Active-high synchronous reset
    input      cpu_overheated,
    output reg shut_off_computer,
    input      arrived,
    input      gas_tank_empty,
    output reg keep_driving  
);

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      shut_off_computer <= 1'b0; // Reset the shutdown signal
    end else begin
      if (cpu_overheated)
        shut_off_computer <= 1'b1;
      else
        shut_off_computer <= 1'b0;
    end
  end

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      keep_driving <= 1'b0; // Reset the driving signal
    end else begin
      if (~arrived)
        keep_driving <= ~gas_tank_empty;
      else
        keep_driving <= 1'b0; // If arrived, stop driving
    end
  end

endmodule
