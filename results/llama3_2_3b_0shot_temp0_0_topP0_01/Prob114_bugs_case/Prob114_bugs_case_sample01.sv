

module TopModule (
  input [7:0] code,
  output reg [3:0] out,
  output reg valid
);

reg [3:0] out;
reg valid;

always @(*) begin
    // Define the valid cases for each key
    case(code)
        8'h45 : out = 0, valid = 1;
        8'h16 : out = 1, valid = 1;
        8'h1e : out = 2, valid = 1;
        8'h26 : out = 3, valid = 1;
        8'h25 : out = 4, valid = 1;
        8'h2e : out = 5, valid = 1;
        8'h36 : out = 6, valid = 1;
        8'h3d : out = 7, valid = 1;
        8'h3e : out = 8, valid = 1;
        8'h46 : out = 9, valid = 1;
        default: out = 0, valid = 0;
    endcase
endmodule
