Assuming your domain is waltuh.cyou,
To generate a dkim key, Do the following:

	openssl genrsa -out waltuh.cyou.key 2048
	openssl rsa -in waltuh.cyou.key -pubout -out waltuh.cyou.pub

Then in waltuh.cyou.pub, Grab the pubkey but remove all of the newline
so it builds into a single line

Like this:

	-----BEGIN PUBLIC KEY-----
	aabbccddeeffgghhiijjkkllmmnnooppqqrrssttuuvv
	wwxxyyzzaabbccddeeffgghhiijjkkllmmnnooppqqrr
	...
	-----END PUBLIC KEY-----

You grab the pubkey string and turn it into a single line:

	aabbccddeeffgghhiijjkkllmmnnooppqqrrssttuuvvwwxxyyzzaabbccddeeffgghhiijjkkllmmnnooppqqrr

Now that's your dkim public key.

Now make a TXT record in <selector>._domainkey.waltuh.cyou.
Replace the <selector> with anything. It could be "mail" so mail._domainkey.waltuh.cyou

The TXT record is:
	v=DKIM1; k=rsa; p=<publickey>

Example:
	v=DKIM1; k=rsa; p=aabbccddeeffgghhiijjkkllmmnnooppqqrrssttuuvvwwxxyyzzaabbccddeeffgghhiijjkkllmmnnooppqqrr

So, in your smtpd.conf:

	filter "dkimsign" proc-exec \
		"filter-dkimsign -d waltuh.cyou -s [selector] -k /etc/mail/dkim/waltuh.cyou.key" \
		user _dkimsign group _dkimsign
 
If your DKIM selector is "mail", then:

	filter "dkimsign" proc-exec \
		"filter-dkimsign -d waltuh.cyou -s mail -k /etc/mail/dkim/waltuh.cyou.key" \
		user _dkimsign group _dkimsign

The rest, Just pass the submission port to the dkimsign filter and let opensmtpd relay it to outside.
