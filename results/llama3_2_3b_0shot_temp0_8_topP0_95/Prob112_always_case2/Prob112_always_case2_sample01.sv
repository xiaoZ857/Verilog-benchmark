
module TopModule (
  input [3:0] in,
  output reg [1:0] pos
);
// Module to create a 4-bit priority encoder
module PriorityEncoder(
  // Input bit vector
  input [3:0] in,
  
  // Output position of the first high bit (1'b0-1'b1)
  output reg [1:0] pos
);

// Create an array to hold possible input combinations and their corresponding output positions
reg [15:8] encoderTable[16:8];

// Initialize the encoder table with all zeros
for(int i = 16; i >= 9; i--) begin : loop
    for (int j = 0; j < 4; j++) begin : bit_loop
        if(i == j) begin
            // Set output position to current bit number for jth input bit
            encoderTable[i] = j + 1;
        end else begin 
            // For all other combinations, set output position to zero
            encoderTable[i] = 0;
        end
    end 
end

// Create an array to hold possible output positions and their corresponding input bit masks
reg [2:0] posMask[3:0];

// Initialize the posMask array with all ones (maximizing the priority)
for(int i = 0; i < 4; i++) begin : bit_loop
    posMask[i] = 1'b1;
end

// Create an expression to calculate output position for each input combination
reg [15:8] tempVar;

assign pos = (in == tempVar ? 
               // If in equals the current input combination, set pos equal to its mask value
               posMask[in]) : 0);

// Initialize tempVar with a 4-bit vector filled with ones
initial begin 
    tempVar[3:0] = 1'b1;
end

endmodule

// VERILOG-EVAL: abnormal backticks count
