
module TopModule (
  input clk,
  input L,
  input q_in,
  input r_in,
  output reg Q
);
reg [1:0] MuxSel; // 2:1 multiplexer selection signals

always @(posedge clk) begin
    if (L) begin
        Q <= r_in;
    end else begin
        MuxSel <= {Q[1], ~Q[0]}; // Select the previous value and the next-to-previous value when L is deasserted
    end
end

assign Q[0] = MuxSel[0] ? r_in[0] : Q[1]; // 2:1 multiplexer for the least significant bit (LSB)
assign Q[1] = MuxSel[1] ? r_in[1] : Q[2]; // 2:1 multiplexer for the middle significant bit (MSB)
assign Q[2] = MuxSel[0] & MuxSel[1] ? r_in[2] : Q[0]; // 2:1 multiplexer for the most significant bit (MSB)

endmodule
