
module TopModule (
    input wire clk,
    input wire [7:0] d,
    input wire areset,
    output reg [7:0] q
);

    // Declare internal registers for each D flip-flop
    reg [7:0] ff;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Asynchronous reset to 0
            ff <= 8'b00000000;
        end else begin
            // Positive edge triggered D flip-flop behavior
            ff <= d;
        end
    end

    // Assign the internal register to output
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            q <= 8'b00000000;
        end else begin
            q <= ff;
        end
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
