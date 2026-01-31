Assuming your domain is waltuh.cyou,
To generate a dkim key, Do the following:

	openssl genpkey -algorithm ed25519 -outform PEM -out /etc/mail/dkim/waltuh.cyou-ed25519.key
	chown _dkimsign:_dkimsign /etc/mail/dkim/waltuh.cyou-ed25519.key

Now, Generate the TXT record string by running the following:

	printf "v=DKIM1;k=ed25519;p=%s" "$(openssl pkey -outform DER -pubout -in /etc/mail/dkim/private.ed25519.key | tail -c +13 | openssl base64)"

Now make a TXT record in <selector>._domainkey.waltuh.cyou.
Replace the <selector> with anything. It could be "mail" so mail._domainkey.waltuh.cyou

Then, Put the previously generated TXT record for the DKIM into this domain

So, in your smtpd.conf:

	filter "dkimsign" proc-exec \
		"filter-dkimsign -a ed25519-sha256 -d waltuh.cyou -s [selector] -k /etc/mail/dkim/waltuh.cyou-ed25519.key" \
		user _dkimsign group _dkimsign
 
If your DKIM selector is "mail", then:

	filter "dkimsign" proc-exec \
		"filter-dkimsign -a ed25519-sha256 -d waltuh.cyou -s mail -k /etc/mail/dkim/waltuh.cyou-ed25519.key" \
		user _dkimsign group _dkimsign

The rest, Just pass the submission port to the dkimsign filter and let opensmtpd relay it to outside.

NOTICE: If DMARC reports show DKIM=PASS from an unknown IP:
          * First check whether the message was forwarded, replayed, or came from a mailing list.
          * Only rotate DKIM keys if you suspect the private key is exposed or the messages are not replays of legitimate mail
