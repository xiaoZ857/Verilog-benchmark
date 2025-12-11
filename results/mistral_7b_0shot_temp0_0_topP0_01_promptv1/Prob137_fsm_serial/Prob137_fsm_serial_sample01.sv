
module TopModule (
  input clk,
  input in,
  input reset,
  output done
);
 ```verilog
reg [7:0] data;
logic start_bit, stop_bit;
logic idle = ~in;
logic signal_active = !idle & start_bit;
logic state_machine = 0;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        start_bit <= 1'b0;
        stop_bit <= 1'b0;
        data <= 8'b0;
        state_machine <= 0;
    end else begin
        case (state_machine)
            0: begin
                if (!idle && !start_bit) begin
                    start_bit <= 1'b1;
                    state_machine <= 1;
                end
            end,
            1: begin
                data <= {data[6], in};
                if (in) begin
                    if (start_bit && in && !signal_active) begin
                        state_machine <= 2;
                    end
                end
            end,
            2: begin
                data <= {data[5], in};
                if (!signal_active && in) begin
                    if (start_bit && data[6] && data[5]) begin
                        state_machine <= 3;
                    end
                end
            end,
            3: begin
                data <= {data[4], in};
                if (!signal_active && data[5] && data[4]) begin
                    if (start_bit && data[6] && data[5] && data[4]) begin
                        state_machine <= 4;
                    end
                end
            end,
            4: begin
                data <= {data[3], in};
                if (!signal_active && data[4] && data[3]) begin
                    if (start_bit && data[6] && data[5] && data[4] && data[3]) begin
                        state_machine <= 5;
                    end
                end
            end,
            5: begin
                data <= {data[2], in};
                if (!signal_active && data[3] && data[2]) begin
                    if (start_bit && data[6] && data[5] && data[4] && data[3] && data[2]) begin
                        state_machine <= 6;
                    end
                end
            end,
            6: begin
                data <= {data[1], in};
                if (!signal_active && data[2] && data[1]) begin
                    if (start_bit && data[6] && data[5] && data[4] && data[3] && data[2] && data[1]) begin
                        state_machine <= 7;
                    end
                end
            end,
            7: begin
                data <= {data[0], in};
                if (!signal_active && data[1] && data[0]) begin
                    if (start_bit && data[6] && data[5] && data[4] && data[3] && data[2] && data[1] && data[0]) begin
                        state_machine <= 8;
                    end
                end
            end,
            8: begin
                if (in && !signal_active) begin
                    stop_bit <= ~stop_bit;
                    if (stop_bit) begin
                        state_machine <= 0;
                        done <= 1'b1;
                    end
                end
            end
        endcase
    end
end

assign out = done;

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
