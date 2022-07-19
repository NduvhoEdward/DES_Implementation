
% input64 = round(rand(1,64));
% round_i = 1;
% subkey = round(rand(1,48));

function [out32_L,out32_R] = des_round(input64,round_i,subkey)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
L_i_1 = input64(1:32);
R_i_1 = input64(33:64);
L_i = R_i_1;

expans_perm = [32 1 2 3 4 5 4 5 6 7 8 9 ...
    8 9 10 11 12 13 12 13 14 15 16 17 ...
    16 17 18 19 20 21 20 21 22 23 24 25 ...
    24 25 26 27 28 29 28 29 30 31 32 1];
for i=1:48
    R_i(i)=R_i_1(expans_perm(i));
end
subkey = logical(subkey(:)'-'0');   %converting to logical
R_i = xor(R_i,subkey);
% Splitting the input into eight 6-bits groups
%R_i = reshape(R_i,8,6);
R_split = zeros(8,6);
counter = 1;
for i=1:6:48
    %R_split() = [R_split,R_i(i:i+5)];
    R_split(counter,:) = R_i(i:i+5);
    counter = counter+1;
end
% The S_boxes stuff

st{1} = [14	4	13	1	2	15	11	8	3	10	6	12	5	9	0	7;...
    0  15	7	4	14	2	13	1	10	6	12	11	9	5	3	8;...
    4	1	14	8	13	6	2	11	15	12	9	7	3	10	5	0;...
    15	12	8	2	4	9	1	7	5	11	3	14	10	0	6	13];
st{2} = [15	1	8	14	6	11	3	4	9	7	2	13	12	0	5	10;...
    3	13	4	7	15	2	8	14	12	0	1	10	6	9	11	5;...
    0	14	7	11	10	4	13	1	5	8	12	6	9	3	2	15;...
    13	8	10	1	3	15	4	2	11	6	7	12	0	5	14	9];
st{3} = [10	0	9	14	6	3	15	5	1	13	12	7	11	4	2	8;...
    13	7	0	9	3	4	6	10	2	8	5	14	12	11	15	1;...
    13	6	4	9	8	15	3	0	11	1	2	12	5	10	14	7;...
    1	10	13	0	6	9	8	7	4	15	14	3	11	5	2	12];
st{4} = [7	13	14	3	0	6	9	10	1	2	8	5	11	12	4	15;...
    13	8	11	5	6	15	0	3	4	7	2	12	1	10	14	9;...
    10	6	9	0	12	11	7	13	15	1	3	14	5	2	8	4;...
    3	15	0	6	10	1	13	8	9	4	5	11	12	7	2	14];
st{5} = [2	12	4	1	7	10	11	6	8	5	3	15	13	0	14	9;...
    14	11	2	12	4	7	13	1	5	0	15	10	3	9	8	6;...
    4	2	1	11	10	13	7	8	15	9	12	5	6	3	0	14;...
    11	8	12	7	1	14	2	13	6	15	0	9	10	4	5	3];
st{6} = [12	1	10	15	9	2	6	8	0	13	3	4	14	7	5	11;...
    10	15	4	2	7	12	9	5	6	1	13	14	0	11	3	8;...
    9	14	15	5	2	8	12	3	7	0	4	10	1	13	11	6;...
    4	3	2	12	9	5	15	10	11	14	1	7	6	0	8	13];
st{7} = [4	11	2	14	15	0	8	13	3	12	9	7	5	10	6	1;...
    13	0	11	7	4	9	1	10	14	3	5	12	2	15	8	6;...
    1	4	11	13	12	3	7	14	10	15	6	8	0	5	9	2;...
    6	11	13	8	1	4	10	7	9	5	0	15	14	2	3	12];
st{8} = [13	2	8	4	6	15	11	1	10	9	3	14	5	0	12	7;...
    1	15	13	8	10	3	7	4	12	5	6	11	0	14	9	2;...
    7	11	4	1	9	12	14	2	0	6	10	13	15	3	5	8;...
    2	1	14	7	4	10	8	13	15	12	9	0	3	5	6	11];

s_boxs = zeros(4,16,8);
s_box_4bits = "";
for i=1:8
    % Getting the sbox row and column
    row_bits = [R_split(i,1),R_split(i,6)];
    column_bits = [R_split(i,2),R_split(i,3),R_split(i,4),R_split(i,5)];
    
    row = string(row_bits);
    row = str2double(row);
    row  = dec2bin(row)';
    row = bin2dec(row);
    col = string(column_bits);
    col = str2double(col);
    col  = dec2bin(col)';
    col = bin2dec(col);
    
    % Getting 4 bits numbers from the s-boxes
    s_boxs(:,:,i) = st{i};
    s_4bits = dec2bin(s_boxs(row+1,col+1,i),4);
    s_box_4bits = strcat(s_box_4bits,s_4bits);
end

% The P-Box Perm
p_box_perm = [16 7 20 21 29 12 28 17 1 15 23 26 5 18 31 10 ...
    2 8 24 14 32 27 3 9 19 13 30 6 22 11 4 25];

s_box_4bits = convertStringsToChars(s_box_4bits);
for i=1:32
    R_i_pb(i) = s_box_4bits(p_box_perm(i));
end

R_i_pb = logical(R_i_pb(:)'-'0');   % Converting to logical
R_i = xor(R_i_pb, L_i_1);

out32_R = R_i;
out32_L = L_i;
end

