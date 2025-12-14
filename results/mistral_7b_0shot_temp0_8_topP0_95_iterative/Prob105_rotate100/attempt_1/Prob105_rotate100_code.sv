
module TopModule (
  input wire clk,
  input wire load,
  input [1:0] ena,
  input [99:0] data_in,
  output reg [99:0] q
);

reg [99:0] data_reg;
reg rotate_direction;

always @(posedge clk) begin
    if (load) begin
        data_reg <= data_in;
    end else if ((ena == 2'b01) || (ena == 2'b10)) begin
        rotate_direction = ~rotate_direction;
        if (rotate_direction) begin
            data_reg <= {data_reg[98], data_reg[0:99]};
        end else begin
            data_reg <= {data_reg[99], data_reg[1:98]};
        end
    end
end

assign q = data_reg;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
