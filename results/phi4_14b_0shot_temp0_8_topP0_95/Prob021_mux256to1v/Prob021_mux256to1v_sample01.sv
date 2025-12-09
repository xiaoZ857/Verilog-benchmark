
module TopModule (
    input [1023:0] in,
    input [7:0] sel,
    output reg [3:0] out
);

    // Always block triggered on positive edge of clock or any change in 'sel' and 'in'
    always @(*) begin
        // Calculate the starting index for the selected 4-bit word
        integer start_index;
        
        // Use non-blocking assignment for sequential logic simulation purposes
        // Compute start index as sel * 4 since each input is 4 bits wide
        start_index = sel * 4;

        // Assign the output to be the 4-bit segment starting at 'start_index'
        out = in[start_index +: 4];
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
