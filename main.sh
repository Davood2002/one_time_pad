# get mode
echo "Enter 'e' for encryption and 'd' for decryption."
read mode
echo

# encryption mode
if [ "$mode" = e ];
then
    echo "Enter the path to the plaintext:"
    read plain_path
    echo
    echo "Do you have a key (Y/N)?"
    read has_key
    #echo

    if [ "$has_key" != "Y" ] && [ "$has_key" != "N" ];
    then
        echo "Ivalid mode, bye!"
        exit
    elif [ "$has_key" = "Y" ]; 
    then
        echo "Enther the path to the key file:"
        read key_path
        echo
        base64 -d "$key_path" > key.bin
        key_len=$(stat --format=%s key.bin)
        plain_len=$(stat --format=%s ${plain_path})
        if [ "$key_len" != "$plain_len" ];
        then
            echo "File and key must have the same length, bye!"
            echo ${plain_len}
            echo ${key_len}
            rm --force key.bin
            exit
        fi
    else
        # generate key
        key_len=$(stat --format=%s $plain_path)
        openssl rand -out key.bin ${key_len}
    fi

    python XOR.py key.bin ${plain_path}   # gerenate the ciphertext

    if [ "$has_key" = "N" ];
    then
        base64 key.bin > key{${plain_path}} # base64-encoded key
    fi
    rm --force key.bin   
    base64 out.bin > cipher{${plain_path}} &&  rm --force out.bin # base64-encoded ciphertext


# decryption mode
elif [ "$mode" = d ];
then
    echo "Enter the path to the ciphertext:"
    read cipher_path
    echo
    echo "Enter the path to the key file:"
    read key_path
    echo

    len_key=$(stat --format=%s $key_path)
    len_cipher=$(stat --format=%s $cipher_path)

    if [ "$len_key" -ne "$len_cipher" ];
    then
        echo -e "Ciphertext and key file must have the same length, bye!"
        exit
    else
        # convert key and ciphertext into binary files
        base64 -d ${cipher_path} > key.bin
        base64 -d ${key_path} > cipher.bin

        python XOR.py key.bin cipher.bin # decrypt the file
        
        mv out.bin decrypted{${cipher_path}}
        rm --force key.bin
        rm --force cipher.bin
    fi
else
    echo "Invalid mode, bye!"
    exit
fi
