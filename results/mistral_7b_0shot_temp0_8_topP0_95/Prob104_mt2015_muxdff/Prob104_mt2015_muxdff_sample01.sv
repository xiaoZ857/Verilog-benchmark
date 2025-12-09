
module TopModule (
    input clk,
    input L,
    input [2:0] r_in, // load value for each flip-flop
    output reg [2:0] Q  // output of the three flip-flops
);

// Implement the 2:1 multiplexer
reg muxCtrl [1:0];
assign muxCtrl[0] = (L ? 1'b0 : r_in[0]);
assign muxCtrl[1] = (~L && r_in[1] ? 1'b1 : r_in[2]);
wire q_mux;
and gate mux_and1 (.a(r_in[0]), .b(!L), .o(q_mux));
or gate mux_or1 (.a(muxCtrl[0]), .b(q_mux), .o(q_mux));
and gate mux_and2 (.a(r_in[1]), .b(!L), .o(q_mux));
or gate mux_or2 (.a(muxCtrl[1]), .b(q_mux), .o(q_mux));

// Implement the three D flip-flops
reg [1:0] dff_data [2:0];
dff_data[0].D <= q_mux;
dff_data[1].D <= (L ? r_in[1] : dff_data[0].Q);
dff_data[2].D <= (L ? r_in[2] : dff_data[1].Q);
always @(posedge clk) begin
    dff_data[0].Q <= dff_data[0].D;
    dff_data[1].Q <= dff_data[1].D;
    dff_data[2].Q <= dff_data[2].D;
end

assign Q = {dff_data[2].Q, dff_data[1].Q, dff_data[0].Q};

endmodule

// VERILOG-EVAL: errant inclusion of module definition
