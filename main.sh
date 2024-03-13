# get mode
echo "Enter 'e' for encrypting and 'd' for decrypting."
read mode

# encryption mode
if [ "$mode" = e ];
then
    echo "Enter the path to the plaintext:"
    read plain

    # generate key
    length=$(stat --format=%s $plain)
    openssl rand -out key.bin $length
    key=key.bin
    # human-readable key
    base64 key.bin > key:${plain}.txt

    python ${plain} ${key}

    base64 out.txt > cipher:${plain}
    
    # clean things up
    rm --force out.txt
    rm --force ${key}

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