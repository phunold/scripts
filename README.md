Just a bunch of scripts
=======================

* Author: Philipp Hunold

This are just a bunch of scripts I wrote.
Nothing too exciting so far. Just for backup reasons here.

Usage
-----

please change some obvious info like email addresses in the scripts 
and run scripts in cron job:

	$ crontab -e
	10 02 * * * /path/to/scripts 2>&1 >/dev/null

all scripts will create **log** file within the same directory.

	Example: check4snort.sh --> check4snort.log

Thank you.

* any feedback (still) welcome.
* use free of charge.
