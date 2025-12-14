
// Define the population count function
function int unsigned [2:0] population_count(input int unsigned [255:0] vector);
    population_count = $unsigned(vector[254:1]);
endfunction

module TopModule (
  input [254:0] in,
  output reg [7:0] out
);

// Calculate the population count for each bit position from 254 down to 0
always @(posedge clk) begin
  for (int i = 254; i >= 0; i--) begin : PopulationCountLoop
    if (in[i] == 1) begin
      // If the current bit is '1', calculate the population count
      out[population_count(in)] <= $unsigned({i, out[population_count(in)], out[population_count(in) - 1]});
    end else begin
      out[population_count(in)] <= 2'b00;
    end
  end : PopulationCountLoop
end

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
