
module TopModule (
  input clk,
  input j,
  input k,
  input reset,
  output out
);
    // State encoding
    localparam OFF = 1'b0;   // out = 0
    localparam ON  = 1'b1;   // out = 1

    reg state;              // current state

    // State transition – synchronous logic
    always @(posedge clk) begin
        if (reset) begin
            // synchronous reset to OFF
            state <= OFF;
        end else begin
            case (state)
                OFF: state <= j ? ON : OFF;
                ON:  state <= k ? OFF : ON;
                default: state <= OFF; // safety
            endcase
        end
    end

    // Output logic – Moore (output follows state)
    assign out = state;

endmodule
