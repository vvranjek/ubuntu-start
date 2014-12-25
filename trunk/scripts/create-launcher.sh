#! /bin/bash


echo
echo "This program creates a desktop launcher. Just follow the instructions"
echo

echo "Enter the following fields"
echo
echo "Name"
read name

echo "Comment"
read comment
echo "Exec, path to executable"
read exe
echo "Icon, path to an icon"

echo "Terminal, enter true or fals, default is false"
while true; do
    read  tf
    case $tf in
        [true]* ) terminal="true"; break;;
        [false]* ) termina="false"; break;;
        * ) terminal="false";;
    esac
done

echo "Icon, write path/name to icon"
read icon

echo "Type, defaul is application" 
echo "a = application"
echo "l = link"
echo "f = folder" 
while true; do
    read  typ
    case $typ in
        [a]* ) typ="Application"; break;;
        [l]* ) typ="Link"; break;;
	[f]* ) typ="Folder"; break;;
        * ) typ="Folder"; break;;
    esac
done

echo "StartupNotify, enter true or fals, default is true"
while true; do
    read  sn
    case $sn in
        [true]* ) sn="true"; break;;
        [false]* ) sn="false"; break;;
        * ) sn="true";;
    esac
done

echo "Creating launcher"
echo

#cd /home/$USER/Desktop
touch ${name}.desktop

echo $name
echo $comment

echo "[Desktop Entry]" > ${name}.desktop
echo "Name=$name" >> ${name}.desktop
echo "Comment=$comment" >> ${name}.desktop
echo "Exec=$exe" >> ${name}.desktop
echo "Icon=$icon" >> ${name}.desktop
echo "Type=$typ" >> ${name}.desktop
echo "StartUpNotif=$sn" >> ${name}.desktop

