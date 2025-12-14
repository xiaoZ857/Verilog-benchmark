
module TopModule (
  input clk,
  input [7:0] in,
  input reset,
  output [23:0] out_bytes,
  output done
);
module MessageFinder (
  input clk,
  input [7:0] in,
  input reset,
  output reg [23:0] out_bytes,
  output reg done
);

reg [2:0] state; // FSM states: 0 - initial, 1 - waiting for first byte, 2 - receiving message, 3 - done
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 0;
        out_bytes <= 0;
        done <= 0;
    end else if (state == 0 && in[3] == 1) begin
        state <= 1;
        out_bytes <= {in[7:4], 4'bx}; // x is a placeholder value for unused bits
    end else if (state == 1) begin
        out_bytes <= {out_bytes[23:8], in[7:0]};
        state <= 2;
        done <= 0;
    end else if (state == 2 && in[3] == 1) begin
        state <= 3; // signal done immediately after the third byte of each message
        out_bytes <= {out_bytes[23:8], in[7:0]};
    end else begin
        state <= state; // stay in the same state if conditions are not met
    end

    if (state == 3) begin
        done <= 1'b1;
    end
end

always @(posedge clk) begin
  reset <= top_module.done; // reset the datapath on FSM's done signal
end

module DataPath (
  input clk,
  input [7:0] in,
  output reg reset,
  output reg [23:0] out_bytes,
  output reg done
);

always @(posedge clk) begin
  reset <= top_module.done; // reset the datapath on FSM's done signal
end

// Assuming there is a module called "top_module" that instantiates MessageFinder and DataPath modules.

// VERILOG-EVAL: endmodule not found
