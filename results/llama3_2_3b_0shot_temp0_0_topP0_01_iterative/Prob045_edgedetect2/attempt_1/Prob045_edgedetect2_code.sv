
module TopModule (
  input clk,
  input [7:0] in,
  output reg [7:0] anyedge
);

reg [7:0] prev_in;
reg [7:0] anyedge;

always @(posedge clk) begin
  // Store the previous value of the input signal
  prev_in <= in;
  
  // Check for edges on each bit of the input signal
  for (int i = 0; i < 8; i++) begin
    if (prev_in[i] == 1 && in[i] == 0) begin
      anyedge[i] <= 1;
    end else if (prev_in[i] == 0 && in[i] == 1) begin
      anyedge[i] <= 1;
    end else begin
      anyedge[i] <= 0;
    end
  end
  
end

// Initialize the output signal to zero
initial begin
  for (int i = 0; i < 8; i++) begin
    anyedge[i] = 0;
  end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
