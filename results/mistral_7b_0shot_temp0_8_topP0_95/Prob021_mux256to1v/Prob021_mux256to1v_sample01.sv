
module TopModule (
  input [1023:0] in,
  input [7:0] sel,
  output reg [3:0] out
);

always @(posedge clk) begin
    case(sel)
        0: out <= in[3:0];
        1: out <= in[7:4];
        2: out <= in[11:8];
        // Add more cases for other sel values up to 7
        8'b1111_1111: out <= in[15:12]; // The last case for sel equals 7
    endcase
end

// If you want to make the reset default value of out to be 0, add a reset signal as below
reg [3:0] reset = 4'b0000; // Initialize to 0s
always @* begin
    if (reset)
        out <= reset;
end

// If you want to include an active-high synchronous reset signal
input sync_rst;
reg [3:0] reset = 4'b0000; // Initialize to 0s
always @* begin
    if (sync_rst && !clk)
        reset <= 4'b0000;
end

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
