

module TopModule (
  input clk,
  input j,
  input k,
  input reset,
  output out
);

always @(posedge clk) begin
    if (reset) begin
        state <= "OFF";
    end else begin
        case (state)
            "OFF": 
                if (j == 1) state <= "ON";
                // else remains OFF
            "ON": 
                if (k == 1) state <= "OFF";
                // else remains ON
        endcase
    end
end

assign out = (state == "ON") ? 1 : 0;

// VERILOG-EVAL: endmodule not found
