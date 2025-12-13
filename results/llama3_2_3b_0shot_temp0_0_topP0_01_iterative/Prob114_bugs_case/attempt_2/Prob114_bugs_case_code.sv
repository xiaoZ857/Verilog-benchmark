
module TopModule (
  input [7:0] code,
  output reg [3:0] out,
  output reg valid
);
always_comb begin
    if(code == 8'h45) 
        temp_out = 0;
    else if(code == 8'h16) 
        temp_out = 1;
    else if(code == 8'h1e) 
        temp_out = 2;
    else if(code == 8'h26) 
        temp_out = 3;
    else if(code == 8'h25) 
        temp_out = 4;
    else if(code == 8'h2e) 
        temp_out = 5;
    else if(code == 8'h36) 
        temp_out = 6;
    else if(code == 8'h3d) 
        temp_out = 7;
    else if(code == 8'h3e) 
        temp_out = 8;
    else if(code == 8'h46) 
        temp_out = 9;

    // If a match is found, set both outputs to the matched value
    valid = (code != 8'h45 && code != 8'h16 && code != 8'h1e && code != 8'h26 && code != 8'h25 && code != 8'h2e && code != 8'h36 && code != 8'h3d && code != 8'h3e && code != 8'h46);
end

// VERILOG-EVAL: endmodule not found
