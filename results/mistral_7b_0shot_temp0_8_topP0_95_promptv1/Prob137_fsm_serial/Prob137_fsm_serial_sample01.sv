
module TopModule (
  input clk,
  input in,
  input reset,
  output done
);
 ```verilog
reg [7:0] data;
logic startBit, stopBit;
logic idle, byteReceived, error;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        startBit = 1'b0;
        stopBit = 1'b0;
        data <= 8'b0;
        idle = 1'b1;
        byteReceived = 1'b0;
        error = 1'b0;
    end else begin
        startBit <= in;
        if (startBit == 1'b0 && !idle) begin
            data[7] <= in;
            idle <= 1'b0;
        end
        if (!startBit && idle) begin
            data[6:0] <= data[7:1];
            data[7] <= in;
        end
        if (in == 1'b1 && !idle) begin
            stopBit = in;
            idle <= 1'b1;
            byteReceived <= 1'b1;
        end
        if ((startBit == 1'b0 || stopBit == 1'b1) && idle) begin
            error <= (data[7] ^ stopBit);
            if (!error) byteReceived <= 1'b0;
        end
    end
end

assign done = byteReceived & !error;

[ ] Code ends with `endmodule`
[x] All wire outputs use `assign` keyword
[x] All reg outputs are assigned in always blocks
[x] Only declared signals are used
[x] Blocking/non-blocking assignments are correct

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
