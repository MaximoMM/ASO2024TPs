TP3 - Maximo Martinez Moraes - TUP

1)

A- El primer código (conhilos.py) usa hilos para ejecutar tareas simultáneamente, reduciendo el tiempo total y el segundo código (sinhilos.py) ejecuta tareas de manera secuencial, lo que lleva a un tiempo total más largo. La ejecución con hilos puede ser menos predecible que la que no tiene hilos, que al ser secuencial es más predecible.

B- Comparándolo con un compañero los tiempos no son iguales, pero no estan tan alejados.

C- Si descomentas esas líneas se añade una espera adicional en cada hilo. Esto puede agregarle una demora a la variable compartida e influye en el resultado final o en el tiempo de ejecución.

2)
A- Codigo:

```
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h> // para usar intptr_t

#define NUMBER_OF_THREADS 2
#define CANTIDAD_INICIAL_HAMBURGUESAS 20

int cantidad_restante_hamburguesas = CANTIDAD_INICIAL_HAMBURGUESAS;
pthread_mutex_t lock; // Mutex para controlar el acceso a la variable compartida
int turno = 0; // Variable para el turno de acceso

void *comer_hamburguesa(void *tid)
{
    int id = (intptr_t) tid;
    while (1)
    {
        // Esperar al turno
        while (turno != id)
        {
            // Pequeña pausa para evitar consumir recursos innecesarios
            sched_yield();
        }

        pthread_mutex_lock(&lock); // Bloquear la sección crítica
        if (cantidad_restante_hamburguesas > 0)
        {
            printf("Hola! soy el hilo (comensal) %d , me voy a comer una hamburguesa ! ya que todavia queda/n %d \n", id, cantidad_restante_hamburguesas);
            cantidad_restante_hamburguesas--; // me como una hamburguesa
        }
        else
        {
            printf("SE TERMINARON LAS HAMBURGUESAS :( \n");
            pthread_mutex_unlock(&lock); // Desbloquear antes de salir de la función
            pthread_exit(NULL); // forzar terminacion del hilo
        }
        turno = (turno + 1) % NUMBER_OF_THREADS; // Cambiar el turno
        pthread_mutex_unlock(&lock); // Desbloquear la sección crítica
    }
}

int main(int argc, char *argv[])
{
    pthread_t threads[NUMBER_OF_THREADS];
    int status, ret;
    pthread_mutex_init(&lock, NULL); // Inicializar el mutex
    for (int i = 0; i < NUMBER_OF_THREADS; i++)
    {
        printf("Hola!, soy el hilo principal. Estoy creando el hilo %d \n", i);
        status = pthread_create(&threads[i], NULL, comer_hamburguesa, (void *)(intptr_t)i);
        if (status != 0)
        {
            printf("Algo salio mal, al crear el hilo recibi el codigo de error %d \n", status);
            exit(-1);
        }
    }

    for (int i = 0; i < NUMBER_OF_THREADS; i++)
    {
        ret = pthread_join(threads[i], NULL); // espero por la terminacion de los hilos que cree
        if (ret != 0)
        {
            printf("Error al esperar la terminación del hilo %d, código de error %d \n", i, ret);
        }
    }

    pthread_mutex_destroy(&lock); // Destruir el mutex
    printf("Todos los hilos han terminado. Adios!\n");
    return 0; // Finalizar el programa
}
```

![image](https://github.com/MaximoMM/ASO2024TPs/assets/167033604/7d9ac815-eebc-4d00-a99e-d242cd1825ff)

B-

![image](https://github.com/MaximoMM/ASO2024TPs/assets/167033604/f9b19720-3036-4c57-b689-3e0ddcdfc464)
