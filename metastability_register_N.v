

module metastability_register_N
#( parameter busWidth = 1
)
(
input  clk,
input  [busWidth-1:0] busIn,
output [busWidth-1:0] busOut
);

reg [busWidth-1:0] busTemp1 = 1;
reg [busWidth-1:0] busTemp2 = 1;

assign busOut = busTemp2;

	always @(posedge clk)
	begin
		busTemp1 <= busIn;
		busTemp2 <= busTemp1;
	end
	
endmodule
