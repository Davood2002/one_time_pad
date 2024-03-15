# get mode
echo "Enter 'e' for encrypting and 'd' for decrypting."
read mode

# encryption mode
if [ "$mode" = e ];
then
    echo "Enter the path to the plaintext:"
    read plain_path

    # generate key
    length=$(stat --format=%s $plain_path)
    openssl rand -out key.bin $length
    key_path=key.bin
    base64 key.bin > key{${plain_path}}.txt   # base64-encoded key

    python XOR.py ${plain_path} ${key_path}   # gerenate the ciphertext

    base64 out.bin > cipher{${plain_path}}.txt   # base64-encoded ciphertext

    # clean things up
    rm --force out.bin
    rm --force ${key_path}

# decryption mode
elif [ "$mode" = d ];
then
    echo "Enter the path to the ciphertext:"
    read cipher
    echo "Enter the path to the key file:"
    read key
else
    echo "Invalid code, bye!"
    exit
fi
