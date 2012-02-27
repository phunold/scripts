#!/bin/sh

# check Snort rule sets for changes

PATH=/bin:/usr/sbin:/usr/bin

prg=`basename $0 .sh`
log=`dirname $0`/${prg}.log
old_sl=/var/tmp/${prg}/current
new_d=/var/tmp/${prg}/`date +%s`
sig_url="http://<CHANGE-ME>.com"
sig_f="snort-rules-2_9.tgz"

info () { echo "INFO: `date` $@"; }
fatal () { echo "FATAL: `date` $@"; echo "Fatal Error" | mail -s "Error in ${prg}" <you>@example.com; exit 1; }

(
 
# make sure directory exists
[ -d ${new_d} ] || mkdir -p ${new_d}
info "changing directory: ${new_d}"
cd ${new_d}
#download rules
info "downloading: ${sig_url}/${sig_f}"
wget -q ${sig_url}/${sig_f} || fatal "could not download file from: ${sig_url}"

# untar file
info "untaring file: ${sig_f}"
tar xzf ${sig_f} || fatal "could not untar file: ${sig_f}"

# remove downloaded file
rm -f ${sig_f}

# if there is no softlink we run for the very first time...
if [ ! -L ${old_sl} ]; then
	info "no base to compare to, run the first time"
	ln -s ${new_d} ${old_sl}
else
	# any changes?
	info "running diff on directories: ${old_sl} ${new_d}"
	diff -wr ${old_sl} ${new_d}

	if [ $? -ne 0 ]; then
		diff -wr ${old_sl} ${new_d} | mail -s "rules updated" <me>@example.com 
		info "signature updates found, sent email"
		rm -f ${old_sl}
		ln -s ${new_d} ${old_sl}
	else
		info "no signature updates"
		rm -rf ${new_d}
	fi
fi

) 2>&1 | tee -a $log

exit 0
