SSL.md
======


### Server-Side

* https://arcweb.co/securing-websites-nginx-and-client-side-certificate-authentication-linux/

The benefit to having using SSL Client Certificates is that this is all done BEFORE the applicaiton starts up.

To accomplish this, I can create a CA, and a client certificate.  In the nginx container, we give it the signed CA cert. And we give them the signed client certificate.

It's literally that easy.

### Client Side

* http://www.binarytides.com/use-clientside-ssl-certificate-curl-php/

For their side, they have to use ONE line.

        CURLOPT_SSLCERT => $cert_file
