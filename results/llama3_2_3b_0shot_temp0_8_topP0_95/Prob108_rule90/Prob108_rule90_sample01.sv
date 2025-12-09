
module TopModule (
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q
);
// Rule 90 Cellular Automaton Module

module Rule90(
  // Input signals
  input clk, 
  input load,
  
  // Load the initial state from data
  input [511:0] data,
  
  // Output signal to store the next state of the system
  output reg [511:0] q
);

reg [511:1] temp[512]; // Temporary buffer for intermediate calculations

// Initial condition (boundary conditions and load)
assign q = data; 
if(load == 1'b0) temp[0] <= 1; else temp[0] <= 0;
if(load == 1'b0) temp[511] <= 1; else temp[511] <= 0;

// Update the intermediate states using the rule
// For i from 1 to 510 (the second last cell)
for(int i = 0; i < 510; i++) begin: rule_90_temp_update
    // Left neighbor's state
    assign temp[i+1] = temp[i]^temp[i+2];
end

// Update the output signal with the next state of each cell
assign q[511:0] = temp[0:511];

// Assign temporary states to cells on the first and last row
if(load == 1'b0) {
    temp[0] <= q[511]; temp[511] <= q[0];
}

endmodule // Rule90 module
