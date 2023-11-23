`default_nettype none

module bit_adder (
    output wire [2:0] led,
    input wire [5:0] sw 
    );
    
    wire xor2out;
    wire xor4out;    
    wire and2out;
    wire and3out;
    wire and4out;
    wire and5out;    
    
    wire [2:0] carry;
    
    xor_gate xor1 (led[0], sw[0], sw[3]);
    xor_gate xor2 (xor2out, sw[1], sw[4]);
    xor_gate xor3 (led[1], xor2out, carry[0]);
    xor_gate xor4 (xor4out, sw[2], sw[5]);
    xor_gate xor5 (led[2], xor4out, carry[1]);   
     
    and_gate and1 (carry[0], sw[0], sw[3]);
    and_gate and2 (and2out, carry[0], xor2out);
    and_gate and3 (and3out, sw[1], sw[4]);
    and_gate and4 (and4out, carry[1], xor4out);
    and_gate and5 (and5out, sw[2], sw[5]);    
    
    or_gate or1 (carry[1], and2out, and3out);
    or_gate or2 (carry[2], and4out, and5out);
    
endmodule
 
 module xor_gate (
    output wire o,
    input wire a,
    input wire b
    );
    assign o = a ^ b;
endmodule

module and_gate (
    output wire o,
    input wire a,
    input wire b
    );
    assign o = a & b;
endmodule

module or_gate (
    output wire o,
    input wire a,
    input wire b
    );
    assign o = a || b;
endmodule