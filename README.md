
# DES Encryption Implementation

This repository contains an implementation of the Data Encryption Standard (DES) algorithm in MATLAB, created by Nduvho E. Ramashia (ID: 1490804).

## Description

The `DES_1490804` function provided in this repository allows you to encrypt a 64-bit message using a 64-bit key. Both the plaintext message and the key should be provided in hexadecimal form.

The implementation follows the standard DES algorithm, including initial permutation, generation of subkeys, and multiple rounds of encryption. The final ciphertext is produced after the rounds of encryption and is returned as a hexadecimal string.

## Usage

To use the `DES_1490804` function, follow these steps:

1. Make sure you have MATLAB installed on your system.
2. Open the MATLAB software.
3. Copy the `DES_1490804.m` file from this repository and save it in your MATLAB working directory or add the file to your MATLAB path.
4. In the MATLAB command window, call the `DES_1490804` function with the appropriate arguments:

```matlab
ciphertext = DES_1490804(plaintext, key64)
```

- `plaintext`: The 64-bit plaintext message in hexadecimal form.
- `key64`: The 64-bit key in hexadecimal form, entered with the Least Significant Bit (LSB) nibble first.

The function will return the ciphertext as a hexadecimal string.

**Note:** Ensure that the length of the plaintext and key are exactly 64 bits each. If they are not, the function may produce unexpected results.

## Example

Here is an example usage of the `DES_1490804` function:

```matlab
plaintext = '0123456789ABCDEF';  % 64-bit plaintext in hexadecimal
key64 = '133457799BBCDFF1';     % 64-bit key in hexadecimal

ciphertext = DES_1490804(plaintext, key64);

disp(ciphertext);
```

Output:
```
8CA64DE9A1B9C9C5
```

## License

This implementation is provided under the [MIT License](LICENSE), allowing you to use, modify, and distribute the code for both commercial and non-commercial purposes. However, please note that this implementation is intended for educational and informational purposes only, and the author shall not be liable for any damages or misuse of the code.

## Disclaimer

This implementation is based on the DES algorithm, which is considered outdated and vulnerable to certain attacks. It is strongly recommended to use more secure encryption algorithms, such as AES (Advanced Encryption Standard), for real-world applications requiring data protection.

## References

- [Data Encryption Standard (Wikipedia)](https://en.wikipedia.org/wiki/Data_Encryption_Standard)
```
```
