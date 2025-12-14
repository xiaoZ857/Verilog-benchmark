
module TopModule (
    input wire clk,
    input wire resetn,
    input [1:0] byteena,
    input [15:0] d,
    output reg [15:0] q
);

reg [15:0] upper_d, lower_d; // Internal signals to separate the data for upper and lower bytes

always @(posedge clk) begin
    if (!resetn) begin
        upper_d <= 8'b0; // Reset both upper and lower data registers
        lower_d <= 8'b0;
    end else begin
        if (byteena[1]) upper_d <= d[15:8]; // Write to upper byte when enabled
        if (byteena[0]) lower_d <= d[7:0];  // Write to lower byte when enabled
    end
end

always @(posedge clk) begin
    q <= upper_d[15:0]; // Assign the values of upper and lower data registers to outputs
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
