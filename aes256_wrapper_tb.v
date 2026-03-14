`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.01.2026 16:44:05
// Design Name: 
// Module Name: aes256_wrapper_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module aes256_wrapper_tb;

    reg clk;
    reg reset;
    reg enable;

    reg [127:0] plaintext;
    reg [255:0] key;
    wire [127:0] ciphertext;

    // Instantiate DUT
    aes256_wrapper dut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .plaintext(plaintext),
        .key(key),
        .ciphertext(ciphertext)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #10 clk = ~clk;   // 50 MHz
    end

    initial begin
        // NIST AES-256 test vector
        plaintext = 128'h00112233445566778899aabbccddeeff;
        key       = 256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;

        reset  = 1;
        enable = 0;

        #40;
        reset  = 0;
        enable = 1;

        // Wait enough cycles for AES-256 (14 rounds)
        #400;

        $display("==============================================");
        $display("PLAINTEXT  = %h", plaintext);
        $display("KEY        = %h", key);
        $display("CIPHERTEXT = %h", ciphertext);
        $display("EXPECTED   = 8ea2b7ca516745bfeafc49904b496089");
        $display("==============================================");

        if (ciphertext == 128'h8ea2b7ca516745bfeafc49904b496089)
            $display("? AES-256 NIST TEST PASSED");
        else
            $display("? AES-256 NIST TEST FAILED");

        $stop;
    end

endmodule
