#!/bin/sh

# check if snort rpm is available

PATH=/bin:/usr/sbin:/usr/bin

prg=`basename $0 .sh`
log=`dirname $0`/${prg}.log

info () { echo "`date` $@"; }

(
yum -q info snort

if [ $? -eq 0 ]; then
	echo "Snort available" | mail -s "snort update" phunold@niksun.com
	info "snort available"
else
	info "snort not available"
fi
) 2>&1 | tee -a $log

exit 0
