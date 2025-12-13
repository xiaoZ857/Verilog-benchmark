
module TopModule (
  input clk,
  input reset,
  output [3:1] ena,
  output reg [15:0] q
);
  reg [3:0] ones_count;
  reg [3:0] tens_count;
  reg [3:0] hundreds_count;
  reg [3:0] thousands_count;

  // Ones digit counter
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      ones_count <= 0;
    end else begin
      if (ones_count == 9) begin
        ones_count <= 0;
      end else begin
        ones_count <= ones_count + 1;
      end
    end
  end

  // Tens digit counter
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      tens_count <= 0;
    end else begin
      if (tens_count == 9) begin
        tens_count <= 0;
      end else begin
        tens_count <= tens_count + 1;
      end
    end
  end

  // Hundreds digit counter
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      hundreds_count <= 0;
    end else begin
      if (hundreds_count == 9) begin
        hundreds_count <= 0;
      end else begin
        hundreds_count <= hundreds_count + 1;
      end
    end
  end

  // Thousands digit counter
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      thousands_count <= 0;
    end else begin
      if (thousands_count == 9) begin
        thousands_count <= 0;
      end else begin
        thousands_count <= thousands_count + 1;
      end
    end
  end

  // Output assignment
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      q <= 0;
    end else begin
      q <= {thousands_count, hundreds_count, tens_count, ones_count};
    end
  end

  // Enable signals
  assign ena[0] = 1; // Ones digit always enabled
  assign ena[1] = (ones_count == 9); // Tens digit enabled when ones digit rolls over
  assign ena[2] = (tens_count == 9); // Hundreds digit enabled when tens digit rolls over
  assign ena[3] = (hundreds_count == 9); // Thousands digit enabled when hundreds digit rolls over

endmodule
