

module TopModule (
  input cpu_overheated,
  output reg shut_off_computer,
  input arrived,
  input gas_tank_empty,
  output reg keep_driving
);

always @(posedge clk) begin
    if (cpu_overheated)
        shut_off_computer <= 1'b1;
    else
        shut_off_computer <= 1'b0; // Ensure it is reset when not overheated

    if (~arrived)
        keep_driving <= ~gas_tank_empty;
    else
        keep_driving <= 1'b0; // Ensure it is reset when arrived
end

endmodule
