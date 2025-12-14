
module TopModule (
  input clk,
  input resetn,
  input [3:1] r,
  output [3:1] g
);
// Define constants for states and signals
typedef enum logic[2:0]
{
    // States
    A, B, C, D
} state_t;

// State table
state_t state = 'a;  // Initialize state to A

// Always block for state table
always @(posedge clk)
if (!resetn) 
    state <= A; // Reset on active-low synchronous reset

else
begin
    if (r[0] && r[1] == 0 && r[2] == 0) state <= B;
    else if (r[1] && r[0] == 0 && r[2] == 0) state <= C;
    else if (r[0] == 0 && r[1] == 0 && r[2] == 0) state <= D;
end

// Always block for state flip-flops
always @(posedge clk)
if (!resetn) 
    state_t::A;

else
begin
    // Update g[i] signals based on current state and input r[i]
    // Priority system used here: device 1 (g[0]) > device 2 (g[1]) > device 3 (g[2])
    case(state)
        A:      {g[0], g[1], g[2]} <= 'z; // No request, all signals set to zero
        B:      if(r[0]) 
            g[0] <= '1', g[1] <= 'z;
            else if (r[1]) 
                g[1] <= '1', g[2] <= 'z;
                else g[0] <= '1';
        C:      if(r[1]) 
            g[1] <= '1', g[2] <= 'z;
            else if (r[0]) 
                g[0] <= '1'; // Prevent device 3 from getting grant when device 2 is set
                else g[0] <= 'z, g[2] <= '1;
        D:      if(r[1]) 
            g[1] <= '1', g[2] <= 'z;
            else if (r[0]) 
                g[0] <= '1'; // Prevent device 3 from getting grant when device 2 is set
                else g[0] <= 'z, g[2] <= '1;
    endcase

end

// Output signals
assign {g[0], g[1], g[2]} = {g[0], g[1], g[2]};

// VERILOG-EVAL: endmodule not found
