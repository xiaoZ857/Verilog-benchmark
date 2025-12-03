

module TopModule (
  input [254:0] in,
  output reg [7:0] out
);

always @(posedge clk) begin
    integer i;
    reg [7:0] count;

    // Initialize the counter to zero at each clock cycle
    count <= 8'b00000000;

    // Iterate over each bit in the input vector and count '1's
    for (i = 0; i < 255; i = i + 1) begin
        if (in[i]) begin
            count <= count + 1;
        end
    end

    // Assign the final count to the output register
    out <= count;
endmodule
