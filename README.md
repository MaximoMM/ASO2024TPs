TP3 - Maximo Martinez Moraes - TUP

1)

A- El primer código (conhilos.py) usa hilos para ejecutar tareas simultáneamente, reduciendo el tiempo total y el segundo código (sinhilos.py) ejecuta tareas de manera secuencial, lo que lleva a un tiempo total más largo. La ejecución con hilos puede ser menos predecible que la que no tiene hilos, que al ser secuencial es más predecible.

B- Comparándolo con un compañero los tiempos no son iguales, pero no estan tan alejados.

(correccion) C- Al ejecutar el archivo suma_rasta.py, sin sincronización adecuada, se produce una race condition entre los hilos sumador y restador, que acceden y modifican la variable acumuladora simultáneamente. Al introducir una pausa en cada iteración del bucle, se reduce la probabilidad de race condition, pero no se resuelve completamente el problema. Para garantizar la consistencia, es necesario aplicar sincronización, como el uso de threading.Lock, para asegurar que solo un hilo modifique la variable compartida a la vez en la zona crítica.

2)
(correccion) A- Codigo:

```
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

#define NUMBER_OF_THREADS 2
#define CANTIDAD_INICIAL_HAMBURGUESAS 20

int cantidad_restante_hamburguesas = CANTIDAD_INICIAL_HAMBURGUESAS;
int turno = 0; // coloque el codigo aqui
void comer_hamburguesa(voidtid)
{
    while (1 == 1)
    {

        while (turno != (int)tid) //coloque el codigo aqui
            ; 

        // INICIO DE LA ZONA CRÍTICA
        if (cantidad_restante_hamburguesas > 0)
        {
            printf("Hola! Soy el hilo(comensal) %d, me voy a comer una hamburguesa! Todavía quedan %d \n", (int)tid, cantidad_restante_hamburguesas);
            cantidad_restante_hamburguesas--; // Me como una hamburguesa

        }
        else
        {
            printf("SE TERMINARON LAS HAMBURGUESAS  \n");
            turno = (turno + 1)% NUMBER_OF_THREADS;
            pthread_exit(NULL); // Forzar terminación del hilo
        }
        turno = (turno + 1) % NUMBER_OF_THREADS; // coloque el codigo aqui

        // SALIDA DE LA ZONA CRÍTICA
    }
}

int main(int argc, char argv[])
{
    pthread_t threads[NUMBER_OF_THREADS];
    int status, i, ret;

    for (int i = 0; i < NUMBER_OF_THREADS; i++)
    {
        printf("Hola!, soy el hilo principal. Estoy creando el hilo %d \n", i);
        status = pthread_create(&threads[i], NULL, comer_hamburguesa, (void)i);
        if (status != 0)
        {
            printf("Algo salió mal, al crear el hilo recibí el código de error %d \n", status);
            exit(-1);
        }
    }

    for (i = 0; i < NUMBER_OF_THREADS; i++)
    {
        void *retval;
        ret = pthread_join(threads[i], &retval); // Esperar por la terminación de los hilos que creé
    }

    pthread_exit(NULL); // Terminar el programa
}
```
![image](https://github.com/MaximoMM/ASO2024TPs/assets/167033604/95b16502-7558-4f02-bdcc-93b4107662e3)

(correccion) B-

![image](https://github.com/MaximoMM/ASO2024TPs/assets/167033604/d73d0939-c7a4-486d-8041-00b8c011eae3)


