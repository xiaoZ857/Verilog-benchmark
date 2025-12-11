
module TopModule (
  input clk,
  input reset,
  input s,
  input w,
  output reg z
);
reg [1:0] count;
reg [1:0] state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 2'b00; // Reset to initial state A
        count <= 2'b00;
        z <= 1'b0;
    end else begin
        case (state)
            2'b00: begin // State A
                if (s) 
                    state <= 2'b01; // Move to state B
                else
                    state <= 2'b00; // Remain in state A
            end
            2'b01: begin // State B
                count <= count + (w ? 1 : 0);
                if (count == 2'b10) 
                    z <= 1'b1;
                else
                    z <= 1'b0;

                if ((state == 2'b01) && (count == 2'b11)) begin
                    state <= 2'b00; // Go back to check s input again
                    count <= 2'b00;
                end
            end
        endcase
    end
end

always @(*) begin
    case ({s, state})
        {1'b0, 2'b00}: z = 1'b0;
        default:       z = 1'bx; // Keep z undefined for unused states
    endcase
end

endmodule
