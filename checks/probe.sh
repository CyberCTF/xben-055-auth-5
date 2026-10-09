#!/bin/sh
# The login form answers a wrong admin password with its refusal.
curl -fsS --max-time 10 'http://web/index.php?username=admin&password=probe' | grep -q 'you are not the admin'
