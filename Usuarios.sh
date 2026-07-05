#!/bin/bash

altas_usuarios() {
    echo  "* Altas de Usuarios *"
    read -p "Nombre de Usuario: " nomusu

    #para saber si ya existía o se creó usamos:
if id "$nomusu" &>/dev/null; then
    #con este comando hacemos que solo se nos muestre si se creó o no, no nos interesa nada mas.
    echo -e "'$nomusu' ya existe"
else
     #por si acaso preguntamos por crear un directorio principal home
     read -p "¿quiere que se cree un directorio principal Home? (y/n): " create_home
     if [[ "$create_home" =~ ^[Yy]$ ]]; then
            useradd -m "$nomusu"
else
     useradd "$nomusu"
        fi

        if [ $? -eq 0 ]; then
            echo -e "Por favor, establezca contraseña para $nomusu"
            passwd "$nomusu"
            echo -e "'$nomusu' se ha creado sin errores."
        else
            echo -e "No se ha podido crear."
        fi
      
}
bajas_usuarios() {
    echo "* Baja de Usuario *"
    read -p "¿Qué usuario desea eliminar? " nomusu

    if ! id "$username" &>/dev/null; then
        echo -e "'$nomusu' no existe"
    else
        read -p "se quiere eliminar el directorio principal también? (y/n) " del_home
        if [[ "$del_home" =~ ^[Yy]$ ]]; then
            userdel -r "$nomusu"
        else
            userdel "$nomusu"
        fi

        if [ $? -eq 0 ]; then
            echo  "el Usuario '$nomusu' se ha eliminado correctamente."
        else
            echo -e "Fallo al borrar usuario."
        fi
    fi
}
mod_user() {
    echo "* Modificar Usuarios *"
    read -p "Ingrese que usuario quiere modificar: " nomusu

    if ! id "$nomusu" &>/dev/null; then
        echo "Este usuario no existe"
        return
    fi

    echo "1. modificar UID"
    echo "2. Cambiar contraseña"
    read -p "Seleccione qué desea modificar [1-2]: " op_mod

    case $op_mod in
        1)
            read -p "Ingresa nuevo UID " new_uid
            if usermod -u "$new_uid" "$nomusu"; then
                echo -e "UID modificado."
            else
            fi
            ;;
   
        2)
            passwd "$nomusu"
            ;;
        *)
            echo -e "X: Opción no Válida."
            ;;
    esac
}
listado_usuarios() {
    echo -e "\n--- Listado de Usuarios del Sistema (UID >= 1000) ---"
    echo -e "USUARIO\t\tUID\t\tHOME"
    echo "--------------------------------------------------"
    awk -F: '$3 >= 1000 && $3 != 65534 {printf "%-15s %-10s %-20s\n", $1, $3, $6}' /etc/passwd
}
