# ButtonCounter

Writen in Verilog my first attempt at writing synthesisable code for the DE10-Lite dev board

A simple button counter, one button counts up, another counts down. Bounded by 0 and 999999. Uses a binary to BCD converter so I can reuse this to read accelerometer data. This also uses a metastability module to ensure proper clock edge detection

# How to run

iverilog -g2012 -o tb_output.vcd -c logical/filelist -c sim/filelist_tb
vvp tb_output.vcd
gtkwave tb_output.vcd

