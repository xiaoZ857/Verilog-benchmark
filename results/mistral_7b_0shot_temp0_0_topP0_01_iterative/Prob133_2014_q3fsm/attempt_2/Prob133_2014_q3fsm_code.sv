
module TopModule (
  input clk,
  input reset,
  input s,
  input w,
  output reg z
);
reg state; // FSM current state: A, B or C
reg counter; // Counter for consecutive 'w=1' cycles in state B

always @(posedge clk) begin
    if (reset) begin
        state <= 0; // Reset to initial state A
        counter <= 0;
        z <= 0;
    end else if (state == 0 && s == 1) begin
        state <= 1; // Transition from A to B when s=1
    end else if (state == 1) begin
        if (w == 1) begin
            counter <= counter + 1;
            if (counter == 2) begin
                z <= 1;
                state <= 2; // Transition from B to C when w=1 for exactly two consecutive cycles
            end
        end else begin
            counter <= 0;
        end
    end else if (state == 2) begin
        if (w == 1) begin
            counter <= counter + 1;
            if (counter >= 3) begin
                state <= 1; // Transition from C back to B after three consecutive cycles
                counter <= 0;
            end
        end else begin
            counter <= 0;
        end
    end
end

initial begin
    $dumpfile("top_module.vcd");
    $dumpvars(0, TopModule);
    #100; // Simulation time for waveform dumping (optional)
end

// timescale directive should be outside the module definition
`timescale 1ns / 1ps

// VERILOG-EVAL: endmodule not found
