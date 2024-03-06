# Proyecto GCP - Albert Fernández
### La práctica consta de 4 partes, separadas por carpetas en este repositorio.

## Parte 1:
#### Creamos un nuevo proyecto dando permisos de edición al profesor:
![1 1-Proyecto-acceso](https://github.com/KeepCodingCloudDevops8/GCP-AlbertFernandez/assets/118215656/9a7b5cfa-6f97-4d72-9867-1be78e33b557)

#### Creamos varios archivos de facturación para que nos avisen en caso de un gasto no esperado:
![1 2-avisos](https://github.com/KeepCodingCloudDevops8/GCP-AlbertFernandez/assets/118215656/4408113c-b73f-4f71-994a-4b8c09325399)

![1 3-avisos2](https://github.com/KeepCodingCloudDevops8/GCP-AlbertFernandez/assets/118215656/dfd0a60c-9c4c-40f0-aa78-4c5d06e7f80f)

#### Dibujamos la arquitectura que tendrá el proyecto en las partes 2, 3 y 4:
![DiagramaGCP](https://github.com/KeepCodingCloudDevops8/GCP-AlbertFernandez/assets/118215656/d106d740-a25a-437b-9654-3d34d4f39657)


## Parte 2:
#### Creamos una BBDD MySQL y configuarmos copias de seguridad para que se lancen al mediodia. Configuraoms las BBDD con las especificaciones de la práctica:
![2 1-createyusers](https://github.com/KeepCodingCloudDevops8/GCP-AlbertFernandez/assets/118215656/a0243545-9c0c-4041-ad4e-71e5460a5a58)

![2 2-copiassegmdiodia](https://github.com/KeepCodingCloudDevops8/GCP-AlbertFernandez/assets/118215656/adc8e0e3-76d7-46f0-87ba-ce1795baf279)

#### Procedemos a importar y exportar las BBDD y verificamos en los logs que todo esté correcto:
![2 3-bucket](https://github.com/KeepCodingCloudDevops8/GCP-AlbertFernandez/assets/118215656/f9577a2a-4097-4507-8324-11577486270e)

![2 4-logs-imp-exp](https://github.com/KeepCodingCloudDevops8/GCP-AlbertFernandez/assets/118215656/fdebc3f5-340e-48cb-b2bc-ac27643a22e3)

#### Desescalamos la máquina de la BBDD al mínimo CPU y RAM (En caso de haberla creado con los mínimos parámetros no hará falta desescalar):
![2 5-desescalar](https://github.com/KeepCodingCloudDevops8/GCP-AlbertFernandez/assets/118215656/9f32d425-7740-4446-888b-9df255034241)


## Parte 3:
#### Creamos una imagen personalizada con un servidor Apache instalado (Lo podremos instalar mediante SSH o directamente automatizando un código de arranque). Para ello necesitamos una MV con un disco de arranque persistente, de ese modo al eliminar la instancia podremos usar el disco igualmente:
![3 1-vmdiscoarranque](https://github.com/KeepCodingCloudDevops8/GCP-AlbertFernandez/assets/118215656/dda3000c-0e6c-45f3-a3de-d01aa04cf400)

![3 4-imgapache](https://github.com/KeepCodingCloudDevops8/GCP-AlbertFernandez/assets/118215656/f50c29e6-6e0e-4283-9012-0908d1c71939)

![3 4 2-imgapacheok](https://github.com/KeepCodingCloudDevops8/GCP-AlbertFernandez/assets/118215656/e09545f5-f2df-4036-bc1c-69830543970c)

#### A partir de esa imagen creamos una plantilla de instancia con la configuración mínima de CPU y RAM:
![3 5-plantillamin](https://github.com/KeepCodingCloudDevops8/GCP-AlbertFernandez/assets/118215656/ba51e1d6-861c-4bb2-ad62-20ea2891aada)

![3 6-plantilaapartirdimg](https://github.com/KeepCodingCloudDevops8/GCP-AlbertFernandez/assets/118215656/4b1d5b98-320c-4c57-8576-5acd989869a0)

#### Creamos un grupo de instancias de autoescalado (1-4), que use dicha plantilla. La configuramos basada en un bajo consumo de CPU, en mi caso de un 10%:
![3 7gpinstautoesc](https://github.com/KeepCodingCloudDevops8/GCP-AlbertFernandez/assets/118215656/7ef73904-91c3-49cb-b6d2-58fabd1d02a9)

![3 8-cpu10](https://github.com/KeepCodingCloudDevops8/GCP-AlbertFernandez/assets/118215656/8c221659-0589-4a7e-9791-e625c42ed675)

![3 9-inst1-4](https://github.com/KeepCodingCloudDevops8/GCP-AlbertFernandez/assets/118215656/d08a05a6-3484-4f6a-8169-e412d8a2a91f)

#### Para que consigamos que escale, ahora creamos una MV independiente que ataque a la IP propia del grupo de instancias:
![3 11-vmDoS](https://github.com/KeepCodingCloudDevops8/GCP-AlbertFernandez/assets/118215656/5150ef45-79bd-4f57-8d3e-abb3f5712d92)

#### Como se puede observar, este script se va a ejecutar al encender la MV, por lo tanto la deberemos apagar al finalizar el escalado. 
```
sudo ping -s 4096 -i 0.001 [ip del grupo de instancias]
```

#### Comprobamos el escalado:
![3 12-escaladook](https://github.com/KeepCodingCloudDevops8/GCP-AlbertFernandez/assets/118215656/b13b962c-a1c2-4fb1-ae70-c52060a6a43b)

#### Apagamos MV de "DoS":
![3 13-detenmaq](https://github.com/KeepCodingCloudDevops8/GCP-AlbertFernandez/assets/118215656/f2711b8e-69b5-4d68-8b87-58563d2d3937)


## Parte 4:
#### Hacemos un deploy en Google App Engine estándar de la siguiente app:
```
https://github.com/GoogleCloudPlatform/python-docs-samples/tree/main/appengine/standard/cloudsql
```
#### Configuramos el archivo app.yaml con los parámetros de la BBDD de la parte 2:
![4 1-yaml](https://github.com/KeepCodingCloudDevops8/GCP-AlbertFernandez/assets/118215656/a81b3ef6-ef70-49c3-9646-85276e19cb70)

### Importante: 
* En caso de error al hacer el deploy mirar la correcta documentación del archivo app.yaml y los logs de APP ENGINE:
    ![4 0-error](https://github.com/KeepCodingCloudDevops8/GCP-AlbertFernandez/assets/118215656/229c50e5-4610-4b69-9b3b-0ea7394f006a)

    ![4 01-logseroor](https://github.com/KeepCodingCloudDevops8/GCP-AlbertFernandez/assets/118215656/86ae9f2a-6c45-4840-bf19-676048f829e4)

#### Comprobamos el correcto funcionamiento accediento a la URL de la app:
![4 2-deployok](https://github.com/KeepCodingCloudDevops8/GCP-AlbertFernandez/assets/118215656/6c8ddad0-de91-41ba-bcd2-73658e85ccd6)

#### Repetimos el proceso de deploy pero esta vez en un nuevo servicio llamado "practica" y personalizando el nombre de la versión a "version-1-0-0":
![4 3-cambio srrv pract](https://github.com/KeepCodingCloudDevops8/GCP-AlbertFernandez/assets/118215656/854a6b66-d79e-4602-8e2f-c5a5d3d78425)

![4 4-v1](https://github.com/KeepCodingCloudDevops8/GCP-AlbertFernandez/assets/118215656/0ed4afa2-0408-4fac-809d-75b0b6caba99)

```
gcloud app deploy -v version-1-0-0
```

#### Repetimos otra vez el deploy pero ahora cambiando el nombre a "versión-2-0-0":

```
gcloud app deploy -v version-2-0-0
```
![4 5-v2](https://github.com/KeepCodingCloudDevops8/GCP-AlbertFernandez/assets/118215656/752e6a86-864b-453c-9be0-f925956483a0)

#### Cambiamos la distribución del tráfico entre las 2 versiones a aleatorio y con un 50% de probabilidad:
![4 6-divtraf](https://github.com/KeepCodingCloudDevops8/GCP-AlbertFernandez/assets/118215656/233d5462-507a-483f-a05b-ed91a2a475a5)

![4 7-trafdiv50](https://github.com/KeepCodingCloudDevops8/GCP-AlbertFernandez/assets/118215656/af0d3ba6-1a25-4c9e-8e30-e92d433f1b0d)



## Bonus - Terraform:
#### Configuramos el archivo main.tf y añadimos la configuración para el uso de la librería Google Cloud. Para ello accedemos a https://registry.terraform.io/ y buscamos Google hashicorp. Copiamos el script para empezar a usar el proveedor:
```
terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.82.0"
    }
  }
}

provider "google" {
  # Configuration options
}
```
#### Disponemos de toda la documentación necesaria en la misma URL.
#### Seguimos las instrucciones de la práctica (véase el archivo main.tf en la carpeta "Despliegue-terraform").
* Cada vez que agregemos una librería al proyecto hay que repetir el "Terraform init"
* Para verificar si nuestro código es correcto usaremos "Terraform validate"
* Para verificar qué cambios hará en el proyecto antes de realizarlos usaremos "Terraform plan"
* Para aplicar los cambios usaremos "Terraform apply"
* Para destruir el proyecto usaremos "Terraform destroy"
#### En la carpeta variables.tf declaramos todas las variables necesarias.
#### En la carpeta terraform.tfvars introducimos los parámetros de dichas variables.
#### Ejecutamos el comando "apply" para crear los recursos y luego los eliminamos con el comando "destroy" para que no nos cobren de más:

![5 5-terra-apply](https://github.com/KeepCodingCloudDevops8/GCP-AlbertFernandez/assets/118215656/ed998090-eb01-4e3f-944b-c9ce5ba6972e)

![5 6-terra-destroy](https://github.com/KeepCodingCloudDevops8/GCP-AlbertFernandez/assets/118215656/1ed0640b-7450-418b-af5c-c0de8c61a6f5)


