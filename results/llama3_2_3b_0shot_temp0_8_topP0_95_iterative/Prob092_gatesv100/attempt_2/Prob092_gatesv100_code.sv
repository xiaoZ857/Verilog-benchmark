
module TopModule (
  input [99:0] in,
  output [98:0] out_both,
  output [99:1] out_any,
  output [99:0] out_different
);
reg [100:0] temp_in; // temporary storage for in vector

assign temp_in = in;

always @(posedge clk) begin
    int idx_outboth[99];
    for (int i = 0; i < 99; i++) {
        idx_outboth[i] = i + 1;
    }
    out_both <= {temp_in[idx_outbuth[98]] & temp_in[idx_outboth[97]], 
                   temp_in[idx_outboth[98]] & temp_in[idx_outboth[97]], ...};

    int idx_outany[99];
    for (int i = 0; i < 99; i++) {
        if(i > 0) idx_outany[i] = i - 1;
        else idx_outany[i] = in[i]; 
    }
    out_any <= {temp_in[idx_outany[0]] | temp_in[idx_outany[1]], 
                 temp_in[idx_outany[99]] | temp_in[idx_outany[98]], ...};

    int idx_outdiff[99];
    for (int i = 0; i < 99; i++) {
        if(i > 0) idx_outdiff[i] = i - 1;
        else idx_outdiff[i] = in[i]; 
    }
    out_different <= {temp_in[idx_outdiff[98]] != temp_in[idx_outdiff[0]], 
                       ...};
endmodule
