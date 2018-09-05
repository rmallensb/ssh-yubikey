#!/bin/sh

# Reset PIV
yubico-piv-tool -a verify-pin -P 000000
yubico-piv-tool -a verify-pin -P 000000
yubico-piv-tool -a verify-pin -P 000000
yubico-piv-tool -a verify-pin -P 000000
yubico-piv-tool -a change-puk -P 000000 -N 00000000
yubico-piv-tool -a change-puk -P 000000 -N 00000000
yubico-piv-tool -a change-puk -P 000000 -N 00000000
yubico-piv-tool -a change-puk -P 000000 -N 00000000
yubico-piv-tool -a reset

# Choose a random management key
export mgm=`dd if=/dev/random bs=1 count=24 2>/dev/null | hexdump -v -e '/1 "%02X"'`

# Set management key
yubico-piv-tool -a set-mgm-key -n $mgm

# Generate RSA 2048 key in slot 9a
yubico-piv-tool -a generate -k$mgm -s 9a -o 9apublic.pem --touch-policy=always

# Get attested cert for the public key of the key in slot 9a
yubico-piv-tool -a attest -s 9a > 9acert.pem

# Import slot 9a certificate into slot 9a certificate slot
yubico-piv-tool -a import-certificate -k$mgm -s 9a -i 9acert.pem

# Set ccc and chuid
yubico-piv-tool -k$mgm -a set-ccc -a set-chuid

# Set random PUK and throw away the PUK
yubico-piv-tool -a change-puk -P 12345678 -N `openssl rand -base64 6`

# Ask user to set PIN
yubico-piv-tool -a change-pin -P 123456

# NOTE: Management key is thrown away at the end
