<VirtualHost *:80>
    ServerAdmin webmasters@leodis.ac.uk
    ServerName www.leodis.ac.uk
    ServerAlias leodis.ac.uk leodis.co.uk www.leodis.co.uk leodis.net www.leodis.net

    ProxyRequests off

    <Proxy *>
        Order deny,allow
        Allow from all
    </Proxy>

    <Location />
        ProxyPass http://localhost:1337/
        ProxyPassReverse http://localhost:1337/
    </Location>
</VirtualHost>
