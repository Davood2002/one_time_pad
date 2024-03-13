# this scripts gets two "binary" files,
# performs bit-wise XOR on them,
# and saves the result as a binary file.

import sys
file1 = sys.argv[1]
file2 = sys.argv[2]


with open(file1, "r") as file1 , open(file2, "rb") as file2:
    
    # read input files
    binary1 = file1.read()
    binary2 = file2.read()
    # print(type(binary1), len(binary1))
    # print(type(binary1), len(binary1))

    # Perform XOR operation byte by byte
    xor_result = bytearray()
    for byte1 , byte2 in zip(binary1, binary2):
        xor_result.append(byte1 ^ byte2)

    # save result to a new file
    with open("out.txt" , "wb") as output_file:
        output_file.write(xor_result)