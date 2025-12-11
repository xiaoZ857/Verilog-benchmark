
module TopModule (
  input clk,
  input [7:0] in,
  input reset,
  output [23:0] out_bytes,
  output done
);

  reg [1:0] state;
  reg [7:0] byte1, byte2, byte3;
  reg done_reg;
  reg [23:0] out_bytes_reg;
  
  localparam IDLE = 2'b00;
  localparam GOT_BYTE1 = 2'b01;
  localparam GOT_BYTE2 = 2'b10;
  localparam GOT_BYTE3 = 2'b11;
  
  always @(posedge clk) begin
    if (reset) begin
      state <= IDLE;
      byte1 <= 8'b0;
      byte2 <= 8'b0;
      byte3 <= 8'b0;
      done_reg <= 1'b0;
      out_bytes_reg <= 24'b0;
    end else begin
      case (state)
        IDLE: begin
          done_reg <= 1'b0;
          if (in[3]) begin
            byte1 <= in;
            state <= GOT_BYTE1;
          end
        end
        
        GOT_BYTE1: begin
          byte2 <= in;
          state <= GOT_BYTE2;
        end
        
        GOT_BYTE2: begin
          byte3 <= in;
          out_bytes_reg <= {byte1, byte2, in};
          done_reg <= 1'b1;
          state <= GOT_BYTE3;
        end
        
        GOT_BYTE3: begin
          done_reg <= 1'b0;
          if (in[3]) begin
            byte1 <= in;
            state <= GOT_BYTE1;
          end else begin
            state <=

// VERILOG-EVAL: endmodule not found
