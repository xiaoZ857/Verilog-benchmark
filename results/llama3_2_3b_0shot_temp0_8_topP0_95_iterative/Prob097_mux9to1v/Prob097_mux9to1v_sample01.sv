
assign out = {out[7:0], 1'b0};
case (sel[3:2])
    4'b00:  // sel=0 selects A
        assign out[7:0] = a[7:0];
    4'b01:  // sel=1 selects B
        assign out[7:0] = b[7:0];
    4'b10:  // sel=2 selects C
        assign out[7:0] = c[7:0];
    4'b11:  // sel=3 selects D
        assign out[7:0] = d[7:0];
    default:
        assign out[7:0] = 16'd255;
endcase

assign out[1:0] = {out[2:1], 1'b0};

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
