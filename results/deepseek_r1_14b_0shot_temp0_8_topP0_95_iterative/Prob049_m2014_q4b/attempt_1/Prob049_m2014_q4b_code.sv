
module TopModule (
    input clk,
    input d,
    input ar,
    output logic q
);

always @ (posedge clk)
begin
    if (ar) 
        q <= 0;
    else 
        q <= d;
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
