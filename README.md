# ButtonCounter

Initially writen in verilog and now upgrade to system verilog. This was my first attempt at writing synthesisable code for the DE10-Lite dev board.
When upgrading to sv, the link to the DE10 was most likely broken (I can't test atm).

A simple button counter, one button counts up, another counts down.
Currently the module counts the number of cycles that the button has been held down for and increments it by that amount. Bounded by 0 and 999999.

The system makes use a binary to decimal converter (bcd) - shamelessly taken from the internet (will dig up link).

Note there is a param that use to change the counting from cycle to button press edges,

# How to run (using icarus)
While in the root of the checkout
- iverilog -g2012 -o tb_output.vcd -c logical/filelist -c sim/filelist_tb
- vvp tb_output.vcd
- gtkwave tb_output.vcd

# Notes on TB

Included with the design is a sv testbench that just drives inputs

# Future plans

- Add a switch to go from decimal to hex.
- Write python script to generate inputs and expected outputs
  - Upgrade the TB to read in the test files and drive the design as such for verif purposes

