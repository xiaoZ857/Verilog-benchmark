
module TopModule (
  input clk,
  input in,
  input reset,
  output out
);
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state_a <= 1'b1; // Reset to State A
        state_b <= 1'b0;
        state_c <= 1'b0;
        state_d <= 1'b0;
        out <= 1'b0;
    end else begin
        case (state_a)
            1'b1: begin
                if(in == 1'b0) begin
                    state_a <= 1'b0;
                    state_b <= 1'b1;
                    out <= 1'b0;
                end else begin
                    state_a <= 1'b1;
                    state_b <= 1'b0;
                    out <= 1'b0;
                end
            end
            1'b0: begin
                if(in == 1'b0) begin
                    state_a <= 1'b1;
                    state_c <= 1'b1;
                    out <= 1'b0;
                end else begin
                    state_b <= 1'b1; // State B stays the same for in = 1
                    state_c <= 1'b0;
                    out <= 1'b0;
                end
            end
        endcase

        always @(posedge clk) begin
            if (state_b == 1'b1) begin
                if(in == 1'b0) begin
                    state_b <= 1'b1; // State B stays the same for in = 0
                    state_c <= 1'b1;
                    out <= 1'b0;
                end else begin
                    state_b <= 1'b0;
                    state_c <= 1'b0;
                    out <= 1'b1;
                end
            end
        end

        always @(posedge clk) begin
            if (state_c == 1'b1) begin
                if(in == 1'b0) begin
                    state_a <= 1'b1;
                    state_d <= 1'b1;
                    out <= 1'b0;
                end else begin
                    state_c <= 1'b0;
                    state_b <= 1'b0; // State B stays the same for in = 1
                    out <= 1'b0;
                end
            end
        end
    end
end

// The following line is missing in your original code
outreg out; // Declare output signal as reg type to avoid floating signal errors

endmodule
