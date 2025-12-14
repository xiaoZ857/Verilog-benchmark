
module TopModule (
  input clk,
  input [7:0] in,
  input reset,
  output [23:0] out_bytes,
  output done
);
always @ (posedge clk) begin
    if (reset == 1) begin
        state <= Idle;
        byte1 <= 0;
        byte2 <= 0;
        byte3 <= 0;
        done <= 0;
        out_bytes <= 0;
    end else case (state) begin
        Idle:
            if (in[3] == 1) begin
                state <= State1;
                byte1 <= in;
            end
            else begin
                state <= Idle;
            end
        State1:
            if (in[3] == 1) begin
                state <= State2;
                byte2 <= in;
            end
            else begin
                state <= State1;
            end
        State2:
            if (in[3] == 1) begin
                state <= Done;
                byte3 <= in;
            end
            else begin
                state <= State2;
            end
        Done:
            begin
                done <= 1;
                message = {byte1, byte2, byte3};
                out_bytes <= message;
                // Reset after one cycle to prevent holding done indefinitely
                state <= Idle;
            end
    endcase
end

// VERILOG-EVAL: endmodule not found
