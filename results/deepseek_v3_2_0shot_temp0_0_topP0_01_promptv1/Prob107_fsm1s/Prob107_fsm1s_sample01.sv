
module TopModule (
  input clk,
  input in,
  input reset,
  output out
);
always @(posedge clk) begin
    if (reset) begin
        out <= 1'b1;
    end else begin
        case (out)
            1'b1: begin // State B
                if (in == 1'b0) begin
                    out <= 1'b0; // Go to State A
                end
                // else (in == 1'b1) stay in State B, out remains 1
            end
            1'b0: begin // State A
                if (in == 1'b1) begin
                    out <= 1'b0; // Stay in State A
                end else begin // in == 1'b0
                    out <= 1'b1; // Go to State B
                end
            end
        endcase
    end
end
endmodule
