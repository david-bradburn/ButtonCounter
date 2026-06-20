

module metastability_register_N
#( parameter BUSWIDTH = 1
)
(
input  clk,
input  resetn,
input  [BUSWIDTH-1:0] busIn,
output [BUSWIDTH-1:0] busOut
);

reg [BUSWIDTH-1:0] busTemp1, busTemp2;

assign busOut = busTemp2;

always_ff @(posedge clk or negedge resetn) begin
  if(!resetn) begin
    busTemp1 <= {BUSWIDTH{1'b0}};
    busTemp2 <= {BUSWIDTH{1'b0}};
  end else begin
    busTemp1 <= busIn;
    busTemp2 <= busTemp1;
  end
end

endmodule
