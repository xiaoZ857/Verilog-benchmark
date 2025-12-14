
module TopModule(
    input clk,
    input [7:0] in,
    input reset,
    output done
);

    integer byte_count; // 0-2, 3 for valid message, -1 for invalid data

    always @(posedge clk) begin
        if (reset) begin
            byte_count <= 0;
        end else begin
            if (in[7] == 1) byte_count <= 0;
            else if (byte_count < 2 && in[7] != 1) byte_count <= -1;
            else if (byte_count >= 0 && byte_count < 3) byte_count <= byte_count + 1;
            // If we're at the end of a message, set done
            if (byte_count == 2) begin
                byte_count <= 3;
                done <= 1;
            end else
                done <= 0;
        end
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
