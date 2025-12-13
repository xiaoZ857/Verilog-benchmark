
// Assign statement implementation for out_assign
assign out_assign = (sel_b1 & sel_b2) ? b : a;

// Procedural if statement implementation for out_always using always block
always @ (posedge clk or negedge reset)
begin
    if (sel_b1 && sel_b2) begin
        out_always <= b;
    end else begin
        out_always <= a;
    end
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
