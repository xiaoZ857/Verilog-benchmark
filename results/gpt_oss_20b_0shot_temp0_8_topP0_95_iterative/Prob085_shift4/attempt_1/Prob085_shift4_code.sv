
module TopModule (
    input          clk,     // synchronous clock
    input          areset,  // asynchronous reset (active high, posedge)
    input          load,    // synchronous load (active high)
    input          ena,     // synchronous enable/shift (active high)
    input  [3:0]   data,    // data to load
    output reg [3:0] q      // shift register contents
);

    // Synchronous logic with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            q <= 4'b0000;          // reset to zero
        end
        else if (load) begin
            q <= data;             // load data (higher priority)
        end
        else if (ena) begin
            q <= {1'b0, q[3:1]};   // shift right by one
       

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
