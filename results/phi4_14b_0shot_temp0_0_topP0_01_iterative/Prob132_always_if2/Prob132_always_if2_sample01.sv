
module TopModule (
  input cpu_overheated,
  output reg shut_off_computer,
  input arrived,
  input gas_tank_empty,
  output reg keep_driving
);
module top_module (
    input      cpu_overheated,
    output reg shut_off_computer,
    input      arrived,
    input      gas_tank_empty,
    output reg keep_driving  
);

    always @(*) begin
        if (cpu_overheated)
            shut_off_computer = 1;
        else
            shut_off_computer = 0; // Explicitly set to 0 when not overheated
    end

    always @(*) begin
        if (~arrived) 
            keep_driving = ~gas_tank_empty; // Keep driving only if gas tank is not empty
        else
            keep_driving = 0; // Stop driving once arrived
    end

endmodule
