

module TopModule (
  input clk,
  input resetn,
  input x,
  input y,
  output f,
  output g
);

always @(posedge clk or negedge resetn)
begin
    if (!resetn) begin
        f <= 0;
        g <= 0;
    end else if (clk'event && clk) begin
        if ((x == 1 && x == 0 && x == 1) || (f == 0)) begin
            f <= 1;
            if (y == 1) begin
                g <= 1;
                if (~y && ~y) g <= 0;
            end else begin
                g <= 0;
                if (~y && ~y) g <= 0;
            end
        end else if ((x == 1 && x == 0 && x == 1) && f == 1) begin
            if (y == 1) begin
                g <= 1;
                if (~y && ~y) g <= 0;
            end else begin
                g <= 0;
                if (~y && ~y) g <= 0;
            end
        end
    end
endmodule
