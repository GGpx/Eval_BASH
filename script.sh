#!/bin/bash

#////////////// Validation //////////////////
#Vous devez créer un script Bash qui va permettre de mettre en place une installation complète de Vagrant et Virtualbox sur un poste sous linux. Avant de lancer l’installation de ces paquets, vous devrez vérifier, via une ligne de commande, si ceux-là sont déjà installés et auquel cas, afficher un message à l’utilisateur comme quoi ces logiciels sont déjà installés.

#Votre script devra ensuite permettre de créer un Vagrantfile automatiquement avec des inputs client, en demandant de modifier le nom des deux dossiers synchronisés (local [../data] et distant[/vagrant_data]), en demandant de sélectionner parmi 3 boxes, puis de pouvoir modifier l’adresse IP.
#Une fois mis en place, vous devrez pouvoir afficher toutes les Vagrant en cours d’utilisation sur le système et pouvoir interagir avec, comme par exemple éteindre une machine en particulier.

#Une fois le tout opérationnel, vous lui demanderez s'il souhaite démarrer sa vagrant.

#Une importance particulière devra être apportée au test et affichages des erreurs et a l’ergonomie du logiciel. Bien évidemment, le fonctionnement du script comptera pour la plus grosse partie.

#Petit bonus : Vous demanderez à l'utilisateur s'il souhaite installer apache2, MySQL et PHP7.0 sur son environnement quand la machine sera connectée en SSH. S'il répond "oui", vous lancerez l'installation de ces 3 paquets. Un gros bonus sera apporté si vous parvenez à installer MySQL avec 0000 comme password par défaut, sans que l'utilisateur n'ait à agir.

#Rendu :
#Ce projet doit être rendu à 17h30 au plus tard.
#Vous devrez fournir un ou des scripts fonctionnels et commentés. Un guide utilisateur devra permettre d’utiliser l’application sans connaissance préalable. La validation se fera sur le fonctionnement du script, la qualité de la documentation fournie et la réutilisation des notions étudiées en formation. Le script devra être fourni via GIT et envoyé par mail.

#Adresse mail : a.corrot@it-akademy.fr
#Nom du mail : LINUX1 + Votre nom et prénom
#Contenu : Un lien vers votre repo Git.


#VARIABLE POUR LES COULEURS DE POLICES
bleufonce='\e[0;34m'
neutre='\e[0;m'
rougefonce='\e[0;31m'
vertfonce='\e[0;32m'

#VARIABLE GLOBAL
pwd= pwd

#BIENVENUE
echo -e "$bleufonce BIENVENU DANS LA CRéATION DE LA SUPER VAGROUT $neutre"

sleep 1

echo -e "Voulez-vous commencer l'installation ? $vertfonce O $neutre/$rougefonce n $neutre?"
read response
case $response in
    O)
        echo "Vous allez commencé à initialiser le Vagrantfile dans un premier temps...."
    ;;
    
    n)
        echo "Dommage ! Ciao"
        break
    ;;
esac

sleep 1

#VERIFICATION DES PAQUETS INSTALLER
echo "Nous allons vérifier si les paquets sont installé ou pas..."

sleep 1
dpkg --status grep vagrant
sleep 1

echo -e "$vertfonce Vagrant est bien installé sur votre machine $neutre"

sleep 1.5

clear

#CREATION DU DOSSIER POUR LA VAGRANT
echo "Vous allez à présent créer le dossier de la vagrant où tout les fichiers seront contenu"

sleep 1

read -p "Qu'elle nom voulez-vous donnez à votre fichier : " response2

echo "Vous l'avez nommé $bleufonce $response2 $neutre"
sleep 1

echo "Création du dossier"
sleep 1

mkdir $response2
cd $response2

echo -e "$vertfonce Votre dossier est bien créer $neutre"

sleep 0.5

echo "Et vous êtes à présent dans le répertoire $pwd" 

sleep 1

#DEMANDE POUR LA BOX
echo "Nous allons créer le Vagrantfile"
sleep 0.5
echo "Qu'elle machine voulez-vous utiliser ? [1]ubuntu/xenial64 , [2]ubuntu/trusty64 OU [3]debian/jessy64"

read box
case $box in
    1)
        echo 'Vagrant.configure("2") do |config|
        config.vm.box = "ubuntu/xenial64"' > Vagrantfile
    ;;
    
    2)
        echo 'Vagrant.configure("2") do |config|
        config.vm.box = "ubuntu/trusty64"' > Vagrantfile
    ;;
    
    3)
        echo 'Vagrant.configure("2") do |config|
        config.vm.box = "debian/jessy64"' > Vagrantfile
    ;;
esac


echo "Vous avez choisi la box $bleufonce $box $neutre"

sleep 1

clear

#DEMANDE POUR MODIFIER L'ADRESSE IP
echo "Voulez-vous modifier l'adressage de base de la machine ? $vertfonce O $neutre/$rougefonce n $neutre? "
read ip

case $ip in
    O)
        echo -p "Qu'elle adresse IP voulez-vous avoir ?" ipsaisie
        echo 'config.vm.network "private_network", ip: "'$ipsaisie'"' >> Vagrantfile
    ;;
    
    n)
        echo "Votre adresse sera celle de base : 192.168.30.10"
        echo 'config.vm.network "private_network", ip: "192.168.30.10"' >> Vagrantfile
    ;;
esac

sleep 1

#DEMANDE POUR LE CHANGEMENT DE FICHIER LOCAL & DISTANT
echo "Voulez-vous modifier le fichier local ? $vertfonce O $neutre/$rougefonce n $neutre?"
read folderResponse

sleep 0.5

echo -p "Qu'elle nom voulez-vous donner avec fichier local : (../data) :" nameFolder

case $folderResponse in
    O)
        echo 'config.vm.synced_folder "./'$nameFolder'", "/vagrant_data"' >> Vagrantfile
        echo "Votre fichier local s'appel $bleufonce $folderResponse $neutre"
    ;;
    
    n)
        echo 'config.vm.synced_folder "./data", "/vagrant_data"' >> Vagrantfile
        echo 'Le dossier sera celui de base '$bleufonce'"./data"'$neutre''
    ;;
esac

sleep 1

read -p "Et pour le fichier distant : (/vagrant_data) ? Faut-il le modifier le nom ? $vertfonce O $neutre/$rougefonce n $neutre?" folderDistant

case $folderDistant in
    
    O)
        echo -p "Qu'elle nom voulez-vous donnez au fichier distant ?" folderDistantName
        sed 'config.vm.synced_folder "./'$nameFolder'", "/vagrant_data"'  Vagrantfile
        echo 'config.vm.synced_folder "./'$nameFolder'", "/'$folderDistantName'"' >> Vagrantfile
        sleep 1
        echo "Votre nom de dossier distant sera $folderDistantName"
    ;;
    
    n)
        echo "Votre nom de dossier distant sera celui de base /var/www/html"
        sed 'config.vm.synced_folder "./'$nameFolder'", "/vagrant_data"'  Vagrantfile
        echo 'config.vm.synced_folder "./'$nameFolder'", "/var/www/html"' >> Vagrantfile
    ;;
esac

sleep 1

echo "Voulez-vous démarrer la Vagrout maintenant ? O/n"
read startVagrant
case $startVagrant in
    O)
        echo "Vous allez démarrer votre vagrant..."
        vagrant up
    ;;
    n)
        echo "Tout les prêt pour l'initialisation de la vagrant. G_G"
    ;;
esac