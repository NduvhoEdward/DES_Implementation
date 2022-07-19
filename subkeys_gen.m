%%
% 1490804 -- Nduvho Edward Ramashia
% The function for generating all DES round subkeys

%key64 = '1F1F1F1F0E0E0E0E';
%key64 = '1FFE1FFE0EFE0EFE';
%key64 = '1FFEFE1F0EFEFE0E';
%key64 = 'FFFFFFFFFFFFFFFF';
%key64 = '0000000000000000';

function subkeys = subkeys_gen(key64)

    % Changing the nibbles order so the bits can  
    % reflect the b0 to b63 order of the key
    key64_lil_Endi = key64;
    index = 16;
    for i=1:16
        key64(i) = key64_lil_Endi(index);
        index = index-1;
    end
    %key64 = '133457799BBCDFF1';
    key64 = hexToBinaryVector(key64, 64);

    % Getting the 56 bits key from the 64
    key_perm = [57 49 41 33 25 17 9 1 58 50 42 34 26 18 ...
                10 2 59 51 43 35 27 19 11 3 60 52 44 36 ...
                63 55 47 39 31 23 15 7 62 54 46 38 30 22 ...
                14 6 61 53 45 37 29 21 13 5 28 20 12 4];
    for i=1:56
        key56(i) = key64(key_perm(i));
    end

    % Determining the key class
    zeros = 0;
    ones = 0;
    for i=1:56
        if key56(i)==0
            zeros = zeros+1;
        else
            ones = ones+1;
        end
    end
    if (zeros==ones||zeros==56||ones==56)
        key_class = 'weak key';
    else
        key_class = 'not weak key';
    end

    %k5 = binaryVectorToHex(key56);
    subkeys = {};
    %subkeys_ = zeros(16,1);
    for i=1:16
        [sub_k, key_after] = subkey_gen(key56,i);
        subkeys = [subkeys, sub_k];
        %subkeys_(i) = sub_k;
        key56 = key_after;
        % Converting the char 1s and 0s to numbers 1s and 0s
        key56=char(num2cell(key56));
        key56=reshape(str2num(key56),1,[]);
    end
    uniq_keys = size(unique(subkeys),2);
end


