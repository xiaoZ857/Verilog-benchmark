
module TopModule (
  input [254:0] in,
  output reg [7:0] out
);
always @(posedge clk) begin
  reg [2:0] population_counts[254:0];
  
  for (int i = 254; i >= 0; i--) begin : PopulationCountLoop
    if (in[i] == 1) begin
      population_counts[i] <= $unsigned({population_counts[i - 1] + 1});
    end else if ($unsigned(population_counts[i]) != 0) begin
      population_counts[i] <= 2'b00;
    end 
  end : PopulationCountLoop
  
  out <= population_counts[254:1];
end

// VERILOG-EVAL: endmodule not found
