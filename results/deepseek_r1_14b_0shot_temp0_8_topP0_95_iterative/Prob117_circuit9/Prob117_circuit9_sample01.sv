
module TopModule (
  input clk,
  input a,
  output reg [2:0] q
);
$timescale 1ns / 1ps

always @(posedge clk) begin
  if (a == 0) begin
    q = 4;
  end else begin
    case(q)
      4: 
        if (time < 50ns) q = 5;
        else if (time < 65ns) q = 6;
        else if (time < 75ns) q = 0;
        else if (time < 85ns) q = 0;
    endcase
  end
end

always @(posedge clk) begin
  if (a == 1) begin
    if (time < 40ns) q = 4;
    else if (time < 45ns) q = 0;
    else if (time < 55ns) q = 5;
  end
end

q = 1;

always @(posedge clk) begin
  if (a == 0) begin
    if (time < 40ns) q = 4;
    else if (time < 45ns) q = 0;
    else if (time < 55ns) q = 5;
  end
end

q = 1;

always @(posedge clk) begin
  case(q)
    4: 
      if (a == 0 && time >= 45ns) q = 0;
      else if (a == 0 && time >= 55ns) q = 5;
      else if (a == 1) q = 6;
    default:
      q = 0;
  endcase
end

always @(posedge clk) begin
  case(q)
    4: 
      if (a == 1 && time >= 70ns) q = 0;
      else if (a == 1 && time >= 85ns) q = 1;
      else if (a == 0) q = 6;
    default:
      q = 0;
  endcase
end

always @(posedge clk) begin
  case(q)
    4: 
      if (a == 1 && time >= 75ns) q = 0;
      else if (a == 1 && time >= 85ns) q = 1;
    default:
      q = 0;
  endcase
end

q = 1;

always @(posedge clk) begin
  case(q)
    4: 
      if (a == 1) begin
        if (time < 75ns) q = 6;
        else if (time >= 85ns) q = 0;
      end
  endcase
end

always @(posedge clk) begin
  case(q)
    default: 
      if (a == 1 && time >= 85ns) q = 1;
  endcase
end

q = 1;

always @(posedge clk) begin
  if (a == 

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
