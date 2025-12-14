
module TopModule (
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);
// Clock counter instance
Counter topClkCnter(clk, ena, 
                         .hour(hh[1:2]),
                         .minute(mm),
                         .second(ss),
                         .pm(pm)
    );

// Reset signal block
always @ (posedge reset) begin
    hh <= 12;
    mm <= 0;
    ss <= 0;
    pm <= 1'b0;
end

// Clock counter instance
Counter topClkCnter(clk, ena, 
                         .hour(hh[2:1]),
                         .minute(mm),
                         .second(ss),
                         .pm(pm)
    );

// VERILOG-EVAL: endmodule not found
