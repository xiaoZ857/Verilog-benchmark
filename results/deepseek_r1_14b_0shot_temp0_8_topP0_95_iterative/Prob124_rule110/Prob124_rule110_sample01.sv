
always_ff @(posedge clk) begin
    if (load) begin
        q <= data;
    end else begin
        reg [511:0] next_q;
        for (int i = 0; i < 512; i++) begin
            // Determine left, current, and right cells
            logic left = (i == 0) ? 0 : q[i - 1];
            logic current = q[i];
            logic right = (i == 511) ? 0 : q[i + 1];
            
            case ({left, current, right})
                3'b111: next_q[i] = 0;
                3'b110: next_q[i] = 1;
                3'b101: next_q[i] = 1;
                3'b100: next_q[i] = 0;
                3'b011: next_q[i] = 1;
                3'b010: next_q[i] = 1;
                3'b001: next_q[i] = 1;
                default: next_q[i] = 0;
            endcase
        end
        q <= next_q;
    end
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
