#!/usr/bin/env bash

# Based on dockcross image entrypoint script

# If we are running docker natively, we want to create a user in the container
# with the same UID and GID as the user on the host machine, so that any files
# created are owned by that user. Without this they are all owned by root.

function cp_skel_file()
{
	[ ! -e "${HOME}/${1}" ] && [ -f "/etc/skel/${1}" ] &&
		cp /etc/skel/${1} "${HOME}" &&
		chown ${BUILDER_UID}:${BUILDER_GID} "${HOME}/${1}"
}

if [[ -n ${BUILDER_UID} && -n ${BUILDER_USER} && -n ${BUILDER_UID} && -n ${BUILDER_GROUP} ]]; then

	export HOME=/home/${BUILDER_USER}

	if [ -d "${HOME}" ]; then
		USERADD_OPT="--no-create-home"

		#cp_skel_file ".profile"
		#cp_skel_file ".bashrc"
		#cp_skel_file ".bash_aliases"
		cp_skel_file ".bash_profile"

		chown ${BUILDER_UID}:${BUILDER_GID} ${HOME}
	else
		USERADD_OPT="--create-home"
	fi

	groupadd -o -g ${BUILDER_GID} ${BUILDER_GROUP}
	useradd -o ${USERADD_OPT} -d ${HOME} -g ${BUILDER_GID} -u ${BUILDER_UID} ${BUILDER_USER} 2>/dev/null

	# Enable passwordless sudo capabilities for the user
	echo "${BUILDER_USER} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/passwordless
	chmod 220 /etc/sudoers.d/passwordless

	# Run the command as the specified user/group.
	exec gosu ${BUILDER_UID}:${BUILDER_GID} "$@"
else
	# Just run the command as root.
	exec "$@"
fi
