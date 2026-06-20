`timescale 1ns/1ns


module buttoncounter_tb;

// Parameters

// Ports
reg clk = 0;
wire [7:0] HEX0;
wire [7:0] HEX1;
wire [7:0] HEX2;
wire [7:0] HEX3;
wire [7:0] HEX4;
wire [7:0] HEX5;
wire [1:0] KEY;

reg incButton = 0;
reg decButton = 0;

logic resetn;

assign KEY = {decButton, incButton};

ButtonCounter
ButtonCounter_dut (
  .clk           (clk    ),
  .resetn        (resetn ),
  .hex0          (HEX0   ),
  .hex1          (HEX1   ),
  .hex2          (HEX2   ),
  .hex3          (HEX3   ),
  .hex4          (HEX4   ),
  .hex5          (HEX5   ),
  .key           (KEY    )
);




always begin
    #10;
    clk <= !clk;
end

initial begin
  $dumpfile("tb_output.vcd");
  $dumpvars(0, buttoncounter_tb);
end

initial begin
  resetn = 1'b0;
  #100;
  resetn = 1'b1;

  #1000;
  incButton <= 1'b1;
  #10000;

  incButton <= 1'b0;
  #10000;

  decButton <= 1'b1;
  #5000;

  decButton <= 1'b0;
  #10000;

  $finish;
end


endmodule

