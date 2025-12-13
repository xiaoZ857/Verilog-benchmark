
module TopModule (
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);

// BCD to 7-segment decoder for hours, minutes and seconds
module bcd_to_7seg (
  input [3:0] bcd,
  output wire seg[8]
);

assign seg[0] = bcd[3]; // G
assign seg[1] = bcd[2]; // F
assign seg[2] = bcd[1]; // E
assign seg[3] = {bcd[3], bcd[2], bcd[0]} ; // BC
assign seg[4] = {bcd[3], bcd[2], bcd[1]} ; // AB
assign seg[5] = bcd[0]; // D
assign seg[6] = bcd[3] + bcd[2] + bcd[1] + bcd[0]; // PV

// BCD counter for hours, minutes and seconds
module bcd_counter (
  input clk,
  input reset,
  output reg [7:0] count
);

always @(posedge clk or posedge reset) begin
  if (reset) begin
    count <= 8'b0; // Reset to zero
  end else if (ena) begin
    count <= count + 1; // Increment counter
  end
end

// Instantiate the BCD counters and 7-segment decoders for hours, minutes and seconds
bcd_counter hour_counter (clk, reset, hh);
bcd_counter min_counter (clk, reset, mm);
bcd_counter sec_counter (clk, reset, ss);

// AM/PM indicator based on the hour value
always @(posedge clk) begin
  if (hh[7] && !mm[7]) begin // 12:00 AM
    pm <= 0;
  end else if (hh[7] || mm[7]) begin // 12:00 PM or after
    pm <= 1;
  end
end

// BCD to 7-segment decoder for hours, minutes and seconds
bcd_to_7seg hour_decoder (hh, hh_out);
bcd_to_7seg min_decoder (mm, min_out);
bcd_to_7seg sec_decoder (ss, sec_out);

// Output pins for hours, minutes and seconds
assign out_hh = hh_out;
assign out_mm = min_out;
assign out_ss = sec_out;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
