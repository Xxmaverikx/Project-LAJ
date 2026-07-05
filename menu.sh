#!/bin/bash

source ./usuarios.sh
source ./grupos.sh

verificar() {
        if 
           [ "$EUID" -ne 0 ]; then
                echo -e "Sin permisos, solo root"
                exit 
        fi
}


echo -e "************************************************"
echo -e "*** SISTEMA PARA GESTIONAR USUARIOS Y GRUPOS ***"
echo -e "************************************************"
while true; do
        echo -e "\n¿Què quiere gestionar?"
        echo "1. Usuarios en el sistema"
        echo "2. Grupos en el sistema"
        echo "3. Cerrar Sistema"
        read -p "Seleccione una opciòn [1-3]" op_menu

        case $op_menu in
                1)
                        while true; do
                                echo -e "\n USUARIOS"
                                echo "1. Alta de Usuario"
                                echo "2. Baja de Usuario"
                                echo "3. Modificaciòn de Usuario"
                                echo "4. Listar Usuarios"
                                echo "5. Volver al menù principal"
                                read -p "Opcion [1-5]" op_user
                                case $op_user in
                                        1) altas_usuarios
                      ;;
                                        2) bajas_usuarios
                      ;;
                                        3) mod_user
                      ;;
                                        4) usuarios_lista
                      ;;
                                        5) return
                      ;;
                                        *) echo -e "Opxión no valida" 
                      ;;
                                esac
                        done
                        ;;
                2)
                        while true; do
                                echo -e "\n GRUPOS "
                                echo "1. Alta de Grupo"
                                echo "2. Baja de Grupo"
                                echo "3. Modificaciòn de Grupo"
                                echo "4. Listar Grupos"
                                echo "5. Volver al menù principal"
                                read -p "Opciòn [1-5]" op_group
                                case $op_group in
                                        1) altas_grupo 
                  ;;
                                        2) bajas_grupo 
                  ;;
                                        3) mod_grupo 
                  ;;
                                        4) grupos_lista
                  ;;
                                        5) return
                  ;;
                                        *) echo -e "Opción no válida" 
                  ;;
                                esac
                        done
                        ;;
                3)
                        echo  "Cerrando Sistema"
                        exit 
                        ;;
                *)
 				        echo  "Esa opción no es valida"
                        ;;
                esac
done