
// Define a module named 'TopModule'
module TopModule(
  // Define two 2-bit input ports A and B
  input [1:0] A, 
  input [1:0] B,
  
  // Define an output port z
  output z
);

// Instantiate the module inside
always_comb
  begin
    // Use the == operator for comparison between the two inputs
    // The expression will be 1 if A equals B and 0 otherwise
    z = (A == B);
    
  end
endmodule

// VERILOG-EVAL: errant inclusion of module definition
