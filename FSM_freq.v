// I am doing this basically solely because I am bored

// This code was written by beginning with PHYS 3364, Lab 26 code,
// written by Professor Ashmanskas, and then whittled down / rearranged

`default_nettype none

module freq_finder
(
    input  wire        clk,   // 100 MHz clock built into the BASYS2 board
    input  wire [15:0] sw,    // 16 sliding switches (up=1, down=0)
    input  wire [7:0]  JA,    // 8 pins (JA) can connect to breadboard
    input  wire [7:0]  JB,    // 8 pins (JB) can connect to breadboard
    input  wire [7:0]  JC,    // 8 pins (JC) can connect to breadboard
    input  wire [7:0]  JXADC  // 8 pins (JXADC) can connect to breadboard
    output wire [15:0] led,   // 16 green LEDs, just above sliding switches
);

    // This counter will count 0..524287 over and over again,
    // using the 100 MHz on-board oscillator as its clock input
    wire [26:0] counter_27bit;
    counter_28bit mycounter1 (counter_27bit, clk);

    assign led[0] = counter_28bit[27]; 

endmodule


// This is one way (somewhat tedious) to make a 19-bit
// counter, by using 19 DFFE's, each of whose D inputs
// is wired to the NOT of its own Q output.
module counter_27bit (output wire [18:0] q, input wire clk);
    wire [26:0] enable;
    assign enable[ 0] = 1;
    assign enable[ 1] = q[0];
    assign enable[ 2] = q[ 1:0]=='b11;
    assign enable[ 3] = q[ 2:0]=='b111;
    assign enable[ 4] = q[ 3:0]=='b1111;
    assign enable[ 5] = q[ 4:0]=='h1f;
    assign enable[ 6] = q[ 5:0]=='h3f;
    assign enable[ 7] = q[ 6:0]=='h7f;
    assign enable[ 8] = q[ 7:0]=='hff;
    assign enable[ 9] = q[ 8:0]=='h1ff;
    assign enable[10] = q[ 9:0]=='h3ff;
    assign enable[11] = q[10:0]=='h7ff;
    assign enable[12] = q[11:0]=='hfff;
    assign enable[13] = q[12:0]=='h1fff;
    assign enable[14] = q[13:0]=='h3fff;
    assign enable[15] = q[14:0]=='h7fff;
    assign enable[16] = q[15:0]=='hffff;
    assign enable[17] = q[16:0]=='h1ffff;
    assign enable[18] = q[17:0]=='h3ffff;
    assign enable[19] = q[18:0]=='h7ffff;
    assign enable[20] = q[19:0]=='hfffff;
    assign enable[21] = q[20:0]=='h1fffff;
    assign enable[22] = q[21:0]=='h3fffff;
    assign enable[23] = q[22:0]=='h7fffff;
    assign enable[24] = q[23:0]=='hffffff;
    assign enable[25] = q[24:0]=='h1ffffff;
    assign enable[26] = q[25:0]=='h3ffffff; 
    // I think this whittles the clock down to approx 1Hz

    // Every 'D' input is the NOT of the corresponding 'Q' output
    wire [26:0] d = ~q[26:0];
    dffe mydff0  (q[ 0], clk, d[ 0], enable[ 0]);
    dffe mydff1  (q[ 1], clk, d[ 1], enable[ 1]);
    dffe mydff2  (q[ 2], clk, d[ 2], enable[ 2]);
    dffe mydff3  (q[ 3], clk, d[ 3], enable[ 3]);
    dffe mydff4  (q[ 4], clk, d[ 4], enable[ 4]);
    dffe mydff5  (q[ 5], clk, d[ 5], enable[ 5]);
    dffe mydff6  (q[ 6], clk, d[ 6], enable[ 6]);
    dffe mydff7  (q[ 7], clk, d[ 7], enable[ 7]);
    dffe mydff8  (q[ 8], clk, d[ 8], enable[ 8]);
    dffe mydff9  (q[ 9], clk, d[ 9], enable[ 9]);
    dffe mydff10 (q[10], clk, d[10], enable[10]);
    dffe mydff11 (q[11], clk, d[11], enable[11]);
    dffe mydff12 (q[12], clk, d[12], enable[12]);
    dffe mydff13 (q[13], clk, d[13], enable[13]);
    dffe mydff14 (q[14], clk, d[14], enable[14]);
    dffe mydff15 (q[15], clk, d[15], enable[15]);
    dffe mydff16 (q[16], clk, d[16], enable[16]);
    dffe mydff17 (q[17], clk, d[17], enable[17]);
    dffe mydff18 (q[18], clk, d[18], enable[18]);
    dffe mydff19 (q[19], clk, d[19], enable[19]);
    dffe mydff20 (q[20], clk, d[20], enable[20]);
    dffe mydff21 (q[21], clk, d[21], enable[21]);
    dffe mydff22 (q[22], clk, d[22], enable[22]);
    dffe mydff23 (q[23], clk, d[23], enable[23]);
    dffe mydff24 (q[24], clk, d[24], enable[24]);
    dffe mydff25 (q[25], clk, d[25], enable[25]);
    dffe mydff26 (q[26], clk, d[26], enable[26]);
endmodule

// Verilog idiom for D-type flip-flop with ENABLE feature
module dffe (output wire q, input wire clk, input wire d, input wire enable);
    reg q_reg;
    always @ (posedge clk) if (enable) q_reg <= d;
    assign q = q_reg;
endmodule

// Implement an 8-bit D-type flip-flop, with 'enable' and 'reset' inputs
module dffe_8bit 
  (output wire [7:0] q, 
   input  wire       clk, 
   input  wire [7:0] d,
   input  wire       enable,
   input  wire       reset
   );
    // if 'reset' is asserted, then the data input to the eight
    // flip-flops will be all zeros; otherwise, the data input
    // will just be d[7:0]
    wire [7:0] data = (reset ? 0 : d[7:0]);
    dffe mydff0 (q[0], clk, data[0], enable);
    dffe mydff1 (q[1], clk, data[1], enable);
    dffe mydff2 (q[2], clk, data[2], enable);
    dffe mydff3 (q[3], clk, data[3], enable);
    dffe mydff4 (q[4], clk, data[4], enable);
    dffe mydff5 (q[5], clk, data[5], enable);
    dffe mydff6 (q[6], clk, data[6], enable);
    dffe mydff7 (q[7], clk, data[7], enable);
endmodule