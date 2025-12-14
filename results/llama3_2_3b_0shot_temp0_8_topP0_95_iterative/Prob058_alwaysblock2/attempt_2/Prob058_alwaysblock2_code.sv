
module TopModule (
    input clk,
    input a,
    input b,
    output out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);

// Using Assign Statement (XOR gate)
assign out_assign = a ^ b;

// Combinational Always Block (Using XOR operation directly)
always @(*) 
begin 
    out_always_comb = a ^ b;
end

// Clocked Always Block with Flip-Flop (Using D Flip-Flop and XOR operation)
always @(posedge clk) 
begin 
    // Set the initial state of output reg
    if(!out_always_ff) begin 
        out_always_ff <= 1'b0;  // Initialize to 0
    end 

    // Output using a D Flip-Flop with XOR as input
    out_always_ff <= (a & ~b | b & ~a);

end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
