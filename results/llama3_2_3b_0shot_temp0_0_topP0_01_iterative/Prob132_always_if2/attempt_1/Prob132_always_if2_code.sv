
module TopModule (
  input cpu_overheated,
  output reg shut_off_computer,
  input arrived,
  input gas_tank_empty,
  output reg keep_driving
);
module top_module (
    input      cpu_overheated,
    output     shut_off_computer, // Changed from reg to output
    input      arrived,
    input      gas_tank_empty,
    output     keep_driving  // Changed from reg to output
);

    always @(*) begin
        if (cpu_overheated)
            shut_off_computer = 1;
    end

    always @(*) begin
        if (~arrived) // Added parentheses around ~arrived
            keep_driving = !gas_tank_empty; // Changed from ~ to !
    end

endmodule
