
module TopModule (
    input  wire        clk,    // clock
    input  wire        areset, // asynchronous reset (active‑high, posedge)
    input  wire        load,   // synchronous load (active‑high)
    input  wire        ena,    // synchronous enable for shift right (active‑high)
    input  wire [3:0]  data,   // data to load
    output reg  [3:0]  q       // shift register contents
);

    // Sequential logic with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            q <= 4'b0000;                    // (1) Asynchronous reset
        end
        else if (load) begin
            q <= data;                       // (2) Load takes priority
        end
        else if (ena) begin
            q <= {1'b0, q[3:1]};             // (3) Shift right, MSB zeroed, LSB discarded
        end
        // else: retain current value

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
