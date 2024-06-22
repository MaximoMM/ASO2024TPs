#!/bin/bash

echo "Bienvenido a la topo calc"

echo "Seleccione una opcion:"
echo "1. Suma"
echo "2. Resta"
echo "3. Multiplicacion"
echo "4. Division"

read opcion

echo "Ingresa el primer numero:"
read numero1
echo "Ingresa el segundo numero:"
read numero2

case $opcion in
  1)
    resultado=$((numero1 + numero2))
    echo "Resultado: $resultado"
    ;;
  2)
    resultado=$((numero1 - numero2))
    echo "Resultado: $resultado"
    ;;
  3)
    resultado=$((numero1 * numero2))
    echo "Resultado: $resultado"
    ;;
  4)
    if [ "$numero2" -ne 0 ]; then
      resultado=$((numero1 / numero2))
      echo "Resultado: $resultado"
    else
      echo "Error: Division por cero no permitida."
    fi
    ;;
  *)
    echo "Intente de nuevo."
    ;;
esac