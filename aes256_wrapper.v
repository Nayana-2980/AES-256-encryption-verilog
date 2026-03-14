`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.01.2026 16:42:29
// Design Name: 
// Module Name: aes256_wrapper
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

module aes256_wrapper (
    input  wire        clk,
    input  wire        reset,
    input  wire        enable,
    input  wire [127:0] plaintext,
    input  wire [255:0] key,
    output wire [127:0] ciphertext
);

    // AES-256 parameters
    localparam Nk = 8;
    localparam Nr = 14;

    // Expanded keys
    wire [((Nr + 1) * 128) - 1:0] allKeys;

    // Key Expansion
    KeyExpansion #(Nk, Nr) key_exp (
        .keyIn  (key),
        .keysOut(allKeys)
    );

    // AES Encryption Core
    AESEncrypt #(Nk, Nr) aes_enc (
        .data   (plaintext),
        .allKeys(allKeys),
        .state  (ciphertext),
        .clk    (clk),
        .enable (enable),
        .reset  (reset)
    );

endmodule

