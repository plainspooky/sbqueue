#!/bin/sh

# SOURCE
SBQUEUE_SRC=`pwd`

# DESTINATIOS
SBQUEUE_BIN="${HOME}/bin"
SBQUEUE_DIR="${HOME}/.sbqueue"

# PROGRAMS
CMDENQE='sbqenq'
CMDHELP='sbqhelp'
CMDHOLD='sbqhold'
CMDLIST='sbqlist'
CMDRELE='sbqrelease'
CMDREMO='sbqremove'
CMDSTAT='sbqstat'
CMDSTRT='sbqstart'
CMDSTOP='sbqstop'
CMDVIEW='sbqview'

# VERIFY/CREATE DESTINATIONS
for I in	${SBQUEUE_BIN} ${SBQUEUE_DIR}
do
	if [ ! -d ${I} ]
	then
		echo "<1> Creating '${I}'"
		mkdir ${I}
	fi
done

# COPY PROGRAMS
for I in	mytempfile sbqueue sbqd
do
	echo "<2> Copying '${I}'"
	cp ${SBQUEUE_SRC}/$I ${SBQUEUE_DIR}
	chmod 755 ${SBQUEUE_DIR}/${I}
done

# CREATE DIRECTORIES
cd ${SBQUEUE_DIR}

for I in	error output run tasks
do
	echo "<3> Create './${I}'"
	mkdir $I
done

cd ${SBQUEUE_BIN}

# CREATE COMMANDS
for I in	${CMDENQE} ${CMDHELP} ${CMDHOLD} ${CMDLIST} \
			${CMDRELE} ${CMDREMO} ${CMDSTAT} ${CMDSTRT} \
			${CMDSTOP} ${CMDVIEW}
do
	echo "<4> Creating symlink to '${I}'"
	ln -s ${SBQUEUE_DIR}/sbqueue ${I}
done

# CREATE RC FILE
echo "<5> Creating .sbqueuerc file"
echo "SBQDIR='${SBQUEUE_DIR}'" > ${HOME}/.sbqueuerc

# SAVE CONFIGURATION
echo "<6> Saving SBQueue configuration"
echo "\
# Stupid Batch Queue - configuration file

# sbqueue programns
SBQBIN=${SBQUEUE_BIN}

# time elapsed between tasks (in seconds)
SBQWAIT=5

# my internal variables
SBQERR=${SBQUEUE_DIR}/error
SBQLOG=${SBQUEUE_DIR}/sbqueue.log
SBQOUT=${SBQUEUE_DIR}/output
SBQPID=${SBQUEUE_DIR}/sbqd.pid
SBQRUN=/dev/null
SBQSTA=${SBQUEUE_DIR}/sbqueue.status
SBQTSK=${SBQUEUE_DIR}/tasks

# the sbqueue commands
CMDENQE='$CMDENQE'
CMDHELP='$CMDHELP'
CMDHOLD='$CMDHOLD'
CMDLIST='$CMDLIST'
CMDRELE='$CMDRELE'
CMDREMO='$CMDREMO'
CMDSTAT='$CMDSTAT'
CMDSTRT='$CMDSTRT'
CMDSTOP='$CMDSTOP'
CMDVIEW='$CMDVIEW'" > ${SBQUEUE_DIR}/sbqueue.conf
echo "Done..."

exit 0
