from sys import argv as arg

# define a function to read binary files
def read_binary_file(file_path) -> bytearray:
    with open(file_path, 'rb') as file:
        array = bytearray(file.read())
        return array

# Perform XOR operation byte by byte
def XOR(array1 , array2):
    xor_result = bytearray()
    for byte1 , byte2 in zip(array1 , array2):
        xor_result.append(byte1 ^ byte2)
    return xor_result
    
path1 = arg[1]
path2 = arg[2]

array1 = read_binary_file(path1)
array2 = read_binary_file(path2)

xor_result = XOR(array1 , array2)

# save result to a new file
with open("out.bin" , "wb+") as output_file:
    output_file.write(xor_result)

len(array2)
len(XOR(array1 , array2))
