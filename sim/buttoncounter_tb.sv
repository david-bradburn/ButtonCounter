


module buttoncounter_tb;

  // Parameters

  // Ports
  reg MAX10_CLK1_50 = 0;
  wire [7:0] HEX0;
  wire [7:0] HEX1;
  wire [7:0] HEX2;
  wire [7:0] HEX3;
  wire [7:0] HEX4;
  wire [7:0] HEX5;
  wire [1:0] KEY;

reg incButton = 1;
reg decButton = 1;

assign KEY = {decButton, incButton};

  ButtonCounter
  ButtonCounter_dut (
    .MAX10_CLK1_50 (MAX10_CLK1_50 ),
    .resetn        (resetn),
    .HEX0          (HEX0 ),
    .HEX1          (HEX1 ),
    .HEX2          (HEX2 ),
    .HEX3          (HEX3 ),
    .HEX4          (HEX4 ),
    .HEX5          (HEX5 ),
    .KEY           ( KEY)
  );




  always
  begin
      #10;
      MAX10_CLK1_50 <= !MAX10_CLK1_50;
  end

  initial begin
    $dumpfile("tb_output.vcd");
    $dumpvars(0, buttoncounter_tb);
  end

  initial begin
    resetn <= 1'b0;
    #100;
    resetn <= 1'b1;

    #1000;
    incButton <= 1'b0;
    #1000;

    incButton <= 1'b1;
    #1000;

    decButton <= 1'b0;
    #1000;

    decButton <= 1'b1;
    #1000;

    $finish;
  end


endmodule

