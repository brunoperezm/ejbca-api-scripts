openssl req -new -out server.csr - newkey rsa :2048 \
nodes - sha256 - keyout server.key \
config csr.conf