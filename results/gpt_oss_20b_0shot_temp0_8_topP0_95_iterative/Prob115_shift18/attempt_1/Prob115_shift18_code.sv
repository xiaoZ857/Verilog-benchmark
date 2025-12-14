
module TopModule (
    input  wire        clk,          // clock
    input  wire        load,         // synchronous load
    input  wire        ena,          // enable shift
    input  wire [1:0]  amount,       // shift amount/direction
    input  wire [63:0] data,         // data to load
    output reg  [63:0] q             // shift register contents
);

    // Synchronous process
    always @(posedge clk) begin
        if (load) begin
            // Load path (takes priority over shifting)
            q <= data;
        end
        else if (ena) begin
            // Shift path
            case (amount)
                2'b00: q <= q << 1;                         // left by 1
                2'b01: q <= q << 8;                         // left by 8
                2'b10: q <= $signed(q) >> 1;                // arithmetic right by 1
                2'b11: q <= $signed(q) >> 8;                // arithmetic right by 

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
