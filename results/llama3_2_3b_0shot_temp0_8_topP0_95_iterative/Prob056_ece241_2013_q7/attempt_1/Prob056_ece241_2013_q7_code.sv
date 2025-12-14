
module TopModule (
    input clk,
    input j,
    input k,
    output reg Q
);

reg q_next;

always @(posedge clk) begin
    if (j == 1 && k == 0) 
        q_next = q;
    else if (j == 0 && k == 1)
        q_next = ~q;  
    else if (j == 1 && k == 1) 
        q_next = ~q;
    else
        q_next = q;

    Q <= q_next;
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
