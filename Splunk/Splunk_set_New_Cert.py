import os
import subprocess


# This sets the name of the certificate and key files
CERT_FILE = 'splunk_cert.pem'
KEY_FILE = 'splunk_key.pem'

# This will set the certificate subject info
SUBJECT = '/C=US/ST=Calafornia/L=San Francisco/O=Splunk Inc./OU=IT/CN=splunk.example.com'

# This will generate a new private key
subprocess.run(['openssl', 'genrsa', '-out', KEY_FILE, '2048'])

# This will generate a new certificate signing request
subprocess.run(['openssl', 'req', '-new', '-key', KEY_FILE, '-out', 'splunk_csr.pem', '-subj', SUBJECT])

# This will generate a self-signed certificate using the CSR and private key
subprocess.run(['openssl', 'x509', '-req', '-daye', '365', '-in', 'splunk_csr.pem', '-signkey', KEY_FILE, '-out', CERT_FILE])

# This removes the CSR file
os.remove('splunk_csr.pem')

print( f'New certificate and private key files generated: {CERT_FILE} and {KEY_FILE}')

# This may or may not work in the actual competition but i guess we will see
