#!/bin/bash

altas_grupo() {
        echo -e " * ALTA DE GRUPO * "
        read -p "Nombre de Grupo: " group

        if getent group "$group" &>/dev/null; then
                echo -e "X: este grupo  ya existe."
                return
        fi

        groupadd "$group"
        if [ $? -eq 0 ]; then
                echo -e "El grupo '$grupo' fue creado con éxito."
        else
                echo -e "Ha ocurrido un error al crear el grupo"
        fi
}
bajas_grupo() {
        echo -e "* AJAS DE GRUPO *"
        read -p "¿Qué grupo desea eliminar? " group

        if ! getent group "$group" &>/dev/null; then
                echo -e "X: Este grupo no existe."
                return
        fi

        groupdel "$group"
        if [ $? -eq 0 ]; then
                echo -e "Se ha eliminado el grupo correcamente."
        else
                echo -e "Ha ocurrido un error al eliminar el grupo"
        fi
}
mod_grupo() {
    echo -e "* Modificaciones de un Grupo *"
    read -p "¿Qué grupo desea modificar? " groupname

    if ! getent group "$groupname" &>/dev/null; then
        echo -e "Este grupo no existe."
        return
    fi

    echo "a. Añadir usuario al grupo"
    echo "b. Eliminar usuario del grupo"
    echo "c. Cambiar nombre del grupo"
    read -p "Seleccione una opción [a-c]: " opciones_mod
    case $opciones_mod in
        1)
            read -p "¿Qué usuario quiere añadir? " nomusu_mod
            if id "$nomusu_mod" &>/dev/null; then
                if usermod -aG "nomusu_mod" "nomusu_mod"; then
                    echo -e "Se ha añadido con exito"
                fi
            else
                echo -e "Usuario no encontrado"
            fi
            ;;
        2)
            read -p "¿Qué usuario quiere quitar?: " nomusu_mod
            if id "$nomusu_mod" &>/dev/null; then
                if gpasswd -d "$nomusu_mod" "$groupname"; then
                    echo -e "Se ha quitado al usuario '$nomusu_mod"
                fi
            else
                echo -e "Usuario no encontrado"
            fi
            ;;
        3)
            read -p "Nuevo nombre para el usuario: " newname
            if groupmod -n "$newname "$groupname"; then
                echo -e "El nuevo nombre es: '$newname'"
            fi
            ;;
        *)
            echo -e "Opción inválida."
            ;;
    esac
}


listado_grupo() {
    echo -e "*** Listado de Grupos para el Sistema (GID >= 1000) ***"
    echo -e "GRUPO\t\tGID\t\tMIEMBROS"
    awk -F: '$3 >= 1000 && $3 != 65534 {printf "%-15s %-10s %-20s\n", $1, $3, $4}' /etc/group
}
