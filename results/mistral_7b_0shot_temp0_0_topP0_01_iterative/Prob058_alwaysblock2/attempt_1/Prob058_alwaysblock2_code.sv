
module TopModule (
  input clk,
  input a,
  input b,
  output out_assign,
  output reg out_always_comb,
  output reg out_always_ff
);

// Using assign statement for output out_assign
assign out_assign = a ^ b;

// Using combinational always block for output out_always_comb
always @* begin
    if(a == b)
        out_always_comb <= 0;
    else
        out_always_comb <= 1;
end

// Using clocked always block for output out_always_ff (with a D flip-flop)
reg out_always_ff_temp;
always @(posedge clk) begin
    if(a == b)
        out_always_ff_temp <= 0;
    else
        out_always_ff_temp <= 1;
    out_always_ff <= out_always_ff_temp;
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
