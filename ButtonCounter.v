
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module ButtonCounter(

	//////////// CLOCK //////////
	//input 		          		ADC_CLK_10,
	input 		          		MAX10_CLK1_50,
	//input 		          		MAX10_CLK2_50,

	//////////// SEG7 //////////
	output		     [7:0]		HEX0, // ff is everything off be careful
	output		     [7:0]		HEX1,
	output		     [7:0]		HEX2,
	output		     [7:0]		HEX3,
	output		     [7:0]		HEX4,
	output		     [7:0]		HEX5,

	//////////// KEY //////////
	input 		     [1:0]		KEY
);







//=======================================================
//  REG/WIRE declarations
//=======================================================

wire button1;
wire buttonReg1;
assign button1 = KEY[0];

metastability_register_N
#(
.busWidth(1)
)
metastab1
(
.clk(MAX10_CLK1_50),
.busIn(button1),
.busOut(buttonReg1)
);

wire button2;
wire buttonReg2;
assign button2 = KEY[1];

metastability_register_N
#(
.busWidth(1)
)
metastab2
(
.clk(MAX10_CLK1_50),
.busIn(button2),
.busOut(buttonReg2)
);


reg reset = 1'b1;


integer counter = 0;
integer last_counter = 0;
integer i;
integer n;
integer j;


reg [7:0] num [0:5];
assign HEX0 = num[0];
assign HEX1 = num[1];
assign HEX2 = num[2];
assign HEX3 = num[3];
assign HEX4 = num[4];
assign HEX5 = num[5];

wire [23:0] number;

//999999 is 20 bits


`define zero  8'b11000000
`define one   8'b11111001
`define two   8'b10100100
`define three 8'b10110000
`define four  8'b10011001
`define five  8'b10010010
`define six   8'b10000010
`define seven 8'b11111000
`define eight 8'b10000000
`define nine  8'b10011000

reg [3:0] seg [0:5];



reg startConv = 0;
wire convdone;


Binary_to_BCD
#(
.INPUT_WIDTH(20),
.DECIMAL_DIGITS(6)
)
BCD
(
.i_Clock(MAX10_CLK1_50),
.i_Binary(counter),
.i_Start(startConv),
//
.o_BCD(number),
.o_DV(convdone)
);

//=======================================================
//  Structural coding
//=======================================================

`define idle 2'b0
`define waitingoncount 2'b01
`define update7seg 2'b10

`define waiting 1'b0
`define buttonPressed 1'b1

reg stateButton = `waiting;
reg [1:0] state = `idle;
reg lastButton1 = 1'b1;
reg lastButton2 = 1'b1;

always @(posedge MAX10_CLK1_50)
begin
	case(state)
	
	`idle : 
	begin
		if(last_counter != counter)
		begin
			state <= `waitingoncount;
			startConv <= 1'b1;
			last_counter <= counter;
		end
	end
	
	`waitingoncount :
	begin
		startConv <= 1'b0;
		if(convdone)
			state <= `update7seg;
	end
	
	`update7seg :
	begin
		seg[0] <= number[3:0];
		seg[1] <= number[7:4];
		seg[2] <= number[11:8];
		seg[3] <= number[15:12];
		seg[4] <= number[19:16];
		seg[5] <= number[23:20];
		
		state <= `idle;
	end
	
	endcase
	
end



always @(posedge MAX10_CLK1_50)
begin

	case(stateButton)
		`waiting :
		begin
			if(lastButton1 != buttonReg1)
			begin
				counter = counter + 1;
				stateButton <= `buttonPressed;
				if(counter > 999999)
					counter = 999999;
			end
			else if(lastButton2 != buttonReg2)
			begin
				counter = counter - 1;
				stateButton <= `buttonPressed;
				if(counter < 0)
					counter = 0;
			end
			
			lastButton1 <= buttonReg1;
			lastButton2 <= buttonReg2;
					
		end
		
		`buttonPressed :
		begin
			if(lastButton1 != buttonReg1)
			begin
				stateButton <= `waiting;
			end
			if(lastButton2 != buttonReg2)
			begin
				stateButton <= `waiting;
			end
			
			lastButton1 <= buttonReg1;
			lastButton2 <= buttonReg2;
		
			
		end
	endcase

end



always @(posedge MAX10_CLK1_50)
begin
	if (reset)
	begin
		for (i = 0; i <= 5; i = i + 1)
		begin	
			num[i] <= 8'hff;
		end
		reset <= 1'b0;
	end
	
	else
	begin	
		for (n = 0; n <= 5; n = n + 1)
		begin
			case(seg[n])
				0 : num[n] <=  `zero;
				1 : num[n] <= 	 `one;
				2 : num[n] <=   `two;
				3 : num[n] <= `three;
				4 : num[n] <=  `four;
				5 : num[n] <=  `five;
				6 : num[n] <= 	 `six;
				7 : num[n] <= `seven;
				8 : num[n] <= `eight;
				9 : num[n] <= 	`nine;
				default : num[n] <= 8'hff;
			endcase
		end
	end
		
end


endmodule
