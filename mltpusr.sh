#!/bin/bash
clear
##root?##
if (( EUID != 0 ))
then
  echo "se ha de ejecutar en root"
  exit 9 
fi
##se piden los datos

echo
echo -n "nombre d'usuaris que es vol crear : "
read n_usr
if (( $n_usr < 1 )) || (( $n_usr > 30 ))
then
	echo "nombre incorrecte d'usuaris"
	exit 1
fi
echo -n "nombre base para usuaris: "
read nom_base
echo -n "DAME UN numero UID: "
read uid
############CREANT EL FITXER D'USUARIS I CONTRASENYES###################
echo "lista usuarios" > /root/$nom_base
if (( $? != 0 ))
	then
		echo "Error creando"
		exit 3
	fi
echo "Format de la llista: Nom d'usuari  Contrasenya  UID" >> /root/$nom_base  
##CREANT USUARIS##
for (( num=1; num<=$n_usr; num++ )) 
do
	ctsnya=$(pwgen 10 1)
	nom_usr=$nom_base$num.clot
	echo "$nom_usr  $ctsnya  $uid" >> /root/$nom_base
	useradd $nom_base$num.clot -u $uid -g users -d /home/$nom_base$num.clot -m -s /bin/bash -p $(mkpasswd $ctsnya)
	if (( $? != 0 ))
	then
		echo "Prooblema creant els usuaris"
		exit 2
	fi
	(( uid++ ))   
done 
#############FINALITZANT################
exit 0
