% 1490804 -- Nduvho E. Ramashia
% The function for encrypting 64 bits massage, given a 64 bits key
% The plaintext and massage should be given in hexidecimal form.
% The key should be enter LSB nibble first

function ciphertext = DES_1490804(plaintext,key64)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

Init_perm = [58 50 42 34 26 18 10 2 60 52 44 36 28 20 12 4 ...
            62 54 46 38 30 22 14 6 64 56 48 40 32 24 16 8 ...
            57 49 41 33 25 17 9 1 59 51 43 35 27 19 11 3 ...
            61 53 45 37 29 21 13 5 63 55 47 39 31 23 15 7];

plaintext = hexToBinaryVector(plaintext, 64);        
for i=1:64
    plaintext_after_ip(i)=plaintext(Init_perm(i));
end

subkeys = subkeys_gen(key64);
%DES rounds
round_plaintext = plaintext_after_ip;
for i=1:16
    subkey = subkeys(i);
    subkey = cell2mat(subkey);
    %subkey = mat2str(subkey);
    [L_i, R_i] = des_round(round_plaintext,i,subkey);
    round_plaintext = [L_i, R_i];
end

after_rounds_tx = [round_plaintext(33:64),round_plaintext(1:32)];
final_perm =    [40 8 48 16 56 24 64 32 39 7 47 15 55 23 63 31 ...
                38 6 46 14 54 22 62 30 37 5 45 13 53 21 61 29 ...
                36 4 44 12 52 20 60 28 35 3 43 11 51 19 59 27 ...
                34 2 42 10 50 18 58 26 33 1 41 9 49 17 57 25];
for i=1:64
    ciphertext(i) = after_rounds_tx(final_perm(i));
end
ciphertext = binaryVectorToHex(ciphertext);
end

