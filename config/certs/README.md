## APS Certificate

1. Generate a certificate signing request using the OS X keychain app.
2. Upload CSR to Apple's cert site, requesting Apple Push Notification cert type when prompted. This will eventually trigger a download for the certificate. Import it into the OS X keychain app.
3. Export the private key associated with your new certificate as a P12.
4. Convert your P12 to a PEM via `openssl pkcs12 -in verb-dev-aps.p12 -out verb-dev-aps.pem -nodes -clcerts`.
5. Celebrate! The PEM version can be used in Rails to make requests to the APS. You can double check it worked by opening a test connection: `openssl s_client -connect gateway.sandbox.push.apple.com:2195 -cert verb-dev-aps.pem`
