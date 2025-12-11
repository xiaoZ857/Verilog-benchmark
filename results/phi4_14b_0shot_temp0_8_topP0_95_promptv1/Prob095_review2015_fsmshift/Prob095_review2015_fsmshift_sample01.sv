
module TopModule (
  input clk,
  input reset,
  output shift_ena
);
`logic [3:0] counter;

assign shift_ena = (counter != 4'b0000);

always_ff @(posedge clk or posedge reset) begin
    if (reset)
        counter <= 4'b1111;
    else if (shift_ena && counter != 4'b0000)
        counter <= counter - 1;
    else
        counter <= 4'b0000;
end

endmodule
