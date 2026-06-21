


// Example N-bit counter
module counter #(
  parameter N = 4
  )(
  input wire clk ,
  input wire clr ,
  output reg [N-1:0] q
  );

// N-bit counter
  always @(posedge clk or posedge clr) begin
    if (clr) begin
      q <= 0;
    end else begin
      q <= q + 1;
    end
  end

endmodule
