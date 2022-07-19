%%
% 1490804 -- Nduvho Edward Ramashia
% The function for generating one DES round subkeys

function [subkey_i, next_key] = subkey_gen(key56, round_i)
    key28_L = key56(1:28);
    key28_R = key56(29:56);
    % Preping the halves for bit shift ops
    key28_L = dec2bin(key28_L)';
    key28_L = bin2dec(key28_L);
    key28_R = dec2bin(key28_R)';
    key28_R = bin2dec(key28_R);

    if(round_i==1||round_i==2||round_i==9||round_i==16)
        key28_L = bitrol(fi(key28_L,0,28,0), 1);
        key28_R = bitrol(fi(key28_R,0,28,0), 1);
    else
        key28_L = bitrol(fi(key28_L,0,28,0), 2);
        key28_R = bitrol(fi(key28_R,0,28,0), 2);
    end
    
    key28_L = dec2bin(key28_L, 28);
    key28_R = dec2bin(key28_R, 28);
    
    current_key = [key28_L key28_R];
    next_key = current_key;
    key_compres_perm = [14 17 11 24 1 5 3 28 15 6 21 10 ...
                        23 19 12 4 26 8 16 7 27 20 13 2 ...
                        41 52 31 37 47 55 30 40 51 45 33 48 ...
                        44 49 39 56 34 53 46 42 50 36 29 32];
    for i = 1:48
        k(i) = current_key(key_compres_perm(i));
    end
    
    subkey_i = k;
end
