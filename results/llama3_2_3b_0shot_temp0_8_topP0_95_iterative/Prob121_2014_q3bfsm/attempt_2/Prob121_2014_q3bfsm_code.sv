
module TopModule (
  input clk,
  input reset,
  input x,
  output reg z
);

reg [2:0] currentState;

initial value = 3'b000;
currentState <= value;

always @(posedge clk or reset)
begin
    if(reset == 1) 
        currentState <= 3'b000;
    else
    begin
        case(currentState)
            3'b000: begin
                if(x == 0) 
                    currentState <= 3'b001;
                else if(x == 1) 
                    currentState <= 3'b010;
                else if(x == 2) 
                    currentState <= 3'b011;
            end
            3'b001: begin
                if(x == 0)
                    currentState <= 3'b000;
                else if(x == 1) 
                    currentState <= 3'b011;
                else if(x == 2) 
                    currentState <= 3'b100;
            end
            3'b010: begin
                if(x == 0) 
                    currentState <= 3'b001;
                else if(x == 1) 
                    currentState <= 3'b110;
                else if(x == 2) 
                    currentState <= 3'b011;
            end
            3'b011: begin
                if(x == 0)
                    currentState <= 3'b000;
                else if(x == 1) 
                    currentState <= 3'b010;
                else if(x == 2) 
                    currentState <= 3'b101;
            end
        endcase
    end
end

assign z = (currentState == 3'b001 || currentState == 3'b011);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
