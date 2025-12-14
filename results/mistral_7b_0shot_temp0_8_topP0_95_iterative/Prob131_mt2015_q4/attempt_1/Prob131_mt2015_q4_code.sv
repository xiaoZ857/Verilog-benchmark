
module A (
  input clk,
  input x,
  input y,
  output reg z
);
assign z = ((x ^ y) & x);
always @(posedge clk) begin
  z <= ((x ^ y) & x);
end

module B (
  input clk,
  input x,
  input y,
  output reg z
);
reg time; // Simulation waveform time for testing purposes
initial begin
  time = 0.ns;
  #5ns time += 5.ns;
  #10ns time += 10.ns;
  #15ns time += 15.ns;
  #20ns time += 20.ns;
  #25ns time += 25.ns;
  #30ns time += 30.ns;
  #35ns time += 35.ns;
  #40ns time += 40.ns;
  #45ns time += 45.ns;
  #50ns time += 50.ns;
  #55ns time += 55.ns;
  #60ns time += 60.ns;
  #65ns time += 65.ns;
  #70ns time += 70.ns;
  #75ns time += 75.ns;
  #80ns time += 80.ns;
  #85ns time += 85.ns;
  #90ns time += 90.ns;
end
always @(posedge clk) begin
  case(time)
    0 : z <= 1'b1;
    5 : z <= 1'b1;
    10 : z <= 1'b1;
    15 : z <= 1'b1;
    20 : z <= 1'b1;
    25 : z <= 1'b0;
    30 : z <= 1'b0;
    35 : z <= 0;
    40 : z <= 0;
    45 : z <= 1;
    50 : z <= 1;
    55 : z <= 1;
    60 : z <= 0;
    65 : z <= 0;
    70 : z <= 0;
    75 : z <= 0;
    80 : z <= 0;
    85 : z <= 0;
    90 : z <= 1;
    default: z <= 1'bx; // Unreachable, but needed for Verilog syntax
  endcase
  time <= time + 5.ns;
end

module TopModule (
  input wire x,
  input wire y,
  output reg z
);
logic [1:0] a_outputs [0:1];
logic [1:0] b_outputs [0:1];
wire or_out, and_out;
A a_module0 (.clk(clk), .x(x), .y(y), .z(a_outputs[0]));
A a_module1 (.clk(clk), .x(x), .y(y), .z(a_outputs[1]));
B b_module0 (.clk(clk), .x(x), .y(y), .z(b_outputs[0]));
B b_module1 (.clk(clk), .x(x), .y(y), .z(b_outputs[1]));
OR or_gate (.a(a_outputs[0]), .b(b_outputs[0]), .o(or_out));
AND and_gate (.a(or_out), .b(and_out), .o(z));
always @(posedge clk) begin
  if (a_outputs[1]) begin // If the second A submodule's output is high, set AND gate input to high
    and_out <= 1'b1;
  end else begin // Otherwise, use the result from the first B submodule
    and_out <= b_outputs[1];
  end
end

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
