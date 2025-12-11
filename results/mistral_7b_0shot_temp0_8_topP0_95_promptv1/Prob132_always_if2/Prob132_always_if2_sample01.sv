
module TopModule (
  input cpu_overheated,
  output reg shut_off_computer,
  input arrived,
  input gas_tank_empty,
  output reg keep_driving
);
assign shut_off_computer = cpu_overheated;
always @* begin
    if (cpu_overheated)
        shut_off_computer <= 1'b1;
end

always @(posedge arrived) begin
    if (~arrived)
        keep_driving <= ~gas_tank_empty;
end

// VERILOG-EVAL: endmodule not found
