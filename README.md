# email server setup

deps used:
- opensmtpd
- opensmtpd-filter-dkimsign
- opensmtpd-filter-rspamd
- opensmtpd-table-postgres
- dovecot-core
- dovecot-imapd
- dovecot-lmtpd
- dovecot-pop3d
- dovecot-sieve
- dovecot-pgsql

and finally

- a postgres server for user management
- rspamd for dkim verification and stuff

## pre-setup

1. make `vmail` user and it's dir

```
useradd -m -r -u 5000 -g mail -d /var/vmail -s /sbin/nologin vmail

# Make sure the mail directory exists
sudo mkdir -p /var/vmail
sudo chown -R vmail:mail /var/vmail
sudo chmod -R 700 /var/vmail
```

2. read SPF.txt

3. go check the config in this repo and learn. don't panic, **it has comments for you to understand**.

## tree

```
├── README.md
├── SPF.txt
├── etc
│   ├── dovecot
│   │   ├── dovecot.conf
│   │   └── local.conf
│   ├── mail
│   │   ├── README.md
│   │   ├── dkim
│   │   │   └── README.txt
│   │   ├── hosts
│   │   ├── mailname
│   │   └── postgresql.conf
│   ├── rspamd
│   │   └── local.d
│   │       └── settings.conf
│   └── smtpd.conf
└── pgsql_schemas
    ├── example.sql
    └── schema.sql
```

start by reading `smtpd.conf` first.

after you juggling, read `dovecot.conf`, then read `local.conf`

good luck.
