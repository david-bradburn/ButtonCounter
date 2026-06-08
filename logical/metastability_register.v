

module metastability_register
#( parameter busWidth = 1
)
(
input clk
input reg [busWidth-1:0] regIn
output reg [busWidth-1:0] regOut
);

reg [busWidth-1:0] busTemp1;
reg [busWidth-1:0] busTemp2;

	always @(posedge clk)
	begin
		busTemp1 <= regIn;
		busTemp2 <= busTemp1;
		regOut <= busTemp2;

	end


endmodule
