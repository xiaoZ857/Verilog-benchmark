
module TopModule (
  input clk,
  input [7:0] in,
  input reset,
  output done
);
always @(posedge clk) begin
    if (reset) begin
        byte_count <= 0;
        done <= 1; // Set done to 1 when reset is asserted, so it doesn't remain 0 on reset
    end else begin
        if (byte_count < 0) byte_count <= -1;
        else if (byte_count < 2 && in[7] != 1) byte_count <= -1;
        else if (byte_count == 2 && in[3] == 1) byte_count <= 0;
        else if (byte_count == 2 && in[7] == 1) begin
            done <= 1;
            byte_count <= 3;
        end else if (byte_count < 3 && in[7] != 1) byte_count <= -1;
        else if (byte_count >= 0 && byte_count < 3) byte_count <= byte_count + 1;
    end
end

always @(posedge clk or enabled by reset) 
begin
    // If the first byte is not valid, discard it
    if ((in[7] != 1 || in[3] == 0) && byte_count < 2) byte_count <= -1;
    
    // If we have a valid message in progress and the next byte is not part of that message, discard it
    else if (byte_count >= 0 && byte_count < 3 && ((in[7] != 1 || in[3] == 0))) 
        byte_count <= -1;
        
    // If we have a valid message in progress and the next byte is part of that message, increment byte count
    else if (byte_count >= 0 && byte_count < 3) byte_count <= byte_count + 1;
end

assign done = byte_count == 3;

// VERILOG-EVAL: endmodule not found
