
module TopModule (
    input clk,
    input L,
    input [2:0] r_in,
    output reg [2:0] Q
);

reg [1:0] D; // D flip-flop data input

always @(posedge clk) begin
    if (L) begin
        D <= r_in;
    end else begin
        D <= {r_in[1], r_in[2], Q[0]}; // q[0] becomes the data input for the next clock cycle
    end
end

assign Q = {Q[1], Q[2], D}; // 3-bit register Q is a combination of D flip-flop output and previous two bits

// Implementing a 2:1 multiplexer using Verilog's built-in 'case' statement
always @(posedge clk) begin
    case (L)
        1'b0 : Q[0] <= D; // pass through the D flip-flop output when L is low
        1'b1 : Q[0] <= r_in[0]; // set q[0] to input value r_in[0] when L is high
    endcase
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
