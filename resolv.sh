#!/bin/bash
clear
#Root#
if (( EUID != 0 ))
then
  echo "Ejecutalo con root"
  exit 9
fi

if (( $# != 1 )) #extra
then
	
	echo "Se ha de passar com a minimo un parametro"
	echo "El parametro ha de ser un subdirectorio"
	exit 2
fi
echo "copia de seguridad resolv.conf"
echo
if [[ ! -d /root/$1 ]]
then
	echo -n "NO existe quieres crearlo ? s/n: "
	read opc
	if [[ $opc != "s" ]] && [[ $opc != "S" ]]
	then
		echo "No s'ha creat el subdirectori"
		exit 1
	else
		mkdir /root/$1
	fi
fi

nom_backup=/root/$1/resolv.conf.backup.$(date +"%Y%m%d%H%M")
cp /etc/resolv.conf $nom_backup 
gzip $nom_backup
if [[ -e $nom_backup ]]; then rm $nom_backup; fi

exit 0
