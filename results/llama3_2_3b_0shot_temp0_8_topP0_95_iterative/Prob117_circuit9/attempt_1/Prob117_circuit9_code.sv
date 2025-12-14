
module TopModule (
  input clk,
  input a,
  output reg [2:0] q
);

reg [3:0] internal_q;

always @(posedge clk or rising_edge(clk)) 
begin
    if (a) 
        internal_q <= 4'b000;
    else
        case(internal_q)
            4'b000: internal_q <= 4'b001;
            4'b001: internal_q <= 4'b010;
            4'b010: internal_q <= 4'b100;
            4'b100: internal_q <= 4'b000;
            default: 
                $assertError("Internal Q is not equal to any state", $file, $line);
        endcase
    end
end

assign q = internal_q;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
