
module TopModule (
    input clk, // Positive clock signal (rising edge)
    input a,   // Bit A
    input b,   // Bit B
    output out_assign,  // Output using assign statement
    output reg out_always_comb,  // Output using combinational always block
    output reg out_always_ff  // Output using clocked always block with flip-flop
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

// Testbench
module TopModule_TB;
    reg clk;      // Positive clock signal (rising edge)
    reg a, b;     // Input bits A and B
    wire out_assign, out_always_comb, out_always_ff;

    TopModule UUT(
        .clk(clk),
        .a(a),
        .b(b),
        .out_assign(out_assign),
        .out_always_comb(out_always_comb),
        .out_always_ff(out_always_ff)
    );

endmodule

initial begin
    clk = 1;
    a = 1'b0; 
    b = 1'b0;

    out_assign <= 1'b1;
    out_always_comb <= 1'b0;
    out_always_ff <= 1'b0;

    #10;
    clk = !clk; // Rising edge
    #5;

    a = 1'b1; 
    b = 1'b0;

    #10;
    clk = !clk; // Falling edge
    #5;

end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
