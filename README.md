# Practica 3 Capas Jesús Abril

**Índice**

1. **Descripción de la Infraestructura**
   - Capas de la arquitectura
2. **Servicios a Desplegar**
   - Capa 1: Balanceador de carga
   - Capa 2: Servidores backend y NFS
   - Capa 3: Base de datos
3. **Requerimientos y Personalización**
   - Script de aprovisionamiento
   - HTTPS y dominio público
4. **Proceso de Despliegue**
   - Creación de la VPC
   - Creación de las instancias
   - Comprobación




## 1.**Descripción de la infraestructura**

En esta práctica vamos a configurar una práctica en 3 niveles, en la que tendremos un balanceador de carga en la primera capa, dispondremos de 2 servidores de backend en la segunda capa y de un servidor con el servicio de NFS, para la última capa dispondremos de un servidor de base de datos.
Con respecto a la la infraestructura, solo dispondremos de acceso al exterior desde la capa pública, es decir, desde la primera;tambie+én impediremos la conexion entre la primera y la tercera capa; utilizaremos grupos de seguridad como una medida para proteger las máquinas.

## 2.**Servicios a desplegar**

**-Capa1:** En la primera capa dispondremos de un servidor apache como balanceador de carga

**-Capa2:** La segunda constará de dos servidores web Apache y un servidor NFS que contendrá todos los recursos del CMS para que exportare hacia los servidores Web.

**-Capa3:** La tercera y la última capa tendremos un servidor de base de datos, ya sea Mysql o MariaDB

## 3.**Requerimientos y personalización**

### **-Scripts de aprovisionamiento:**

Script de aprovisionamiento para el balanceador:

![Captura de pantalla 2024-12-04 214627](https://github.com/user-attachments/assets/99b21f5a-4871-42c2-ab8c-f2edd6d0396c)

El script configura un balanceador de carga en Apache en un servidor Ubuntu/Debian. Primero, actualiza los paquetes e instala Apache. Luego, habilita módulos necesarios para el balanceo de carga, como proxy, proxy_http, y proxy_balancer. Crea un archivo de configuración llamado load-balancer.conf, desactiva la raíz predeterminada de Apache y define un clúster (mycluster) con servidores backend, especificando sus direcciones IP para distribuir solicitudes usando el método "por número de peticiones". Finalmente, habilita la nueva configuración, desactiva la configuración por defecto y reinicia Apache para aplicar los cambios.

Script de aprovisionamiento para los servidores web:

![Captura de pantalla 2024-12-04 214726](https://github.com/user-attachments/assets/d48fec79-89ea-4e3e-9ffa-3b2345473925)

Este script configura un servidor web Apache con soporte PHP y un directorio compartido montado desde un servidor NFS. Instala Apache, PHP y varias extensiones necesarias para aplicaciones como WordPress. Habilita el módulo rewrite en Apache, ajusta la configuración del sitio predeterminado para que utilice el directorio /nfs/shared/wordpress como raíz del sitio, y añade permisos para que Apache acceda al directorio. Luego, monta el directorio compartido desde un servidor NFS en la ruta local /nfs/shared. Finalmente, desactiva la configuración predeterminada del sitio, activa una nueva configuración (websv.conf), y reinicia Apache para aplicar los cambios.

Script de aprovisionamiento para el NFS:

![Captura de pantalla 2024-12-04 214839](https://github.com/user-attachments/assets/23e01476-dc5a-4ec4-a7ce-3c9d9a634d23)

Este script configura un servidor NFS para compartir un directorio donde se alojará WordPress. Primero, instala el servidor NFS y herramientas necesarias como curl, unzip, PHP, y el cliente MySQL. Crea el directorio compartido /var/nfs/shared, asignándole permisos básicos y añadiendo reglas a /etc/exports para permitir acceso desde las subredes especificadas (192.168.10.140/24 y 192.168.10.133/24) con opciones como escritura sincronizada (rw,sync). Descarga WordPress desde su sitio oficial, descomprime los archivos en el directorio compartido, ajusta permisos para que los usuarios www-data y nobody tengan acceso adecuado, y finalmente reinicia el servicio NFS para aplicar los cambios.


Script de aprovisionamiento para la base de datos:

![Captura de pantalla 2024-12-04 214923](https://github.com/user-attachments/assets/a4314462-b307-481b-8dca-767c6c58096b)

Este script configura un servidor MySQL y prepara una base de datos para WordPress. Instala MySQL Server, actualiza el sistema y ajusta la configuración en el archivo mysqld.cnf para que el servidor escuche en la dirección IP 192.168.10.157. Luego, reinicia el servicio MySQL para aplicar los cambios. Posteriormente, crea una base de datos llamada db_wordpress y un usuario llamado JesusA, accesible desde cualquier dirección de la subred 192.168.10.%, asignándole la contraseña 1234. Este usuario recibe todos los privilegios sobre la base de datos db_wordpress, y finalmente se actualizan los privilegios con FLUSH PRIVILEGES.

### **-HTTPS y dominio público**

## 4.**Proceso de despliegue**

### **-Creación de la VPC:**

Primero crearemos una VPC con la dirección 192.168.10.0/24, la VPC dispondrá de dos subredes privadas.

![Captura de pantalla 2024-12-03 195335](https://github.com/user-attachments/assets/b97a86fc-ca8c-4581-8a34-cc7247cb7c2c)

![Captura de pantalla 2024-12-03 195344](https://github.com/user-attachments/assets/d1cc0dfd-5c23-44f2-9e59-270c29ff4607)

Vemos que la VPC se ha creado correctamente con las dos subredes:

![Captura de pantalla 2024-12-03 195629](https://github.com/user-attachments/assets/77c98f8b-d9e0-4a2f-82e9-9f6e12f6cf17)



### **-Creación de las instancias**

A continuación vamos a mostrar como se crea una instancia, las demás, se crearan de la misma manera, aunque en la segunda capa, las instancias dispondrán de otros grupos de seguridad,y otras reglas de grupos; además de que tendran otra subred, ya que estas necesitan tener una conexión con la base de datos; vamos a mostrar como creamos el balanceador:

![Captura de pantalla 2024-12-03 200100](https://github.com/user-attachments/assets/d514b7fd-58a5-449f-9cbf-fd5cbb791439)

Le asginamos unas claves de seguridad:

![Captura de pantalla 2024-12-03 200342](https://github.com/user-attachments/assets/f7728745-d3cb-44ea-aa5e-3328e1c131c6)

Al balanceador le asignaremos una subred pública

![Captura de pantalla 2024-12-04 121431](https://github.com/user-attachments/assets/2e0e22da-8b99-4167-abce-5321e9483928)

Y también le asignaremos las siguienres reglas de grupo:

![Captura de pantalla 2024-12-04 121541](https://github.com/user-attachments/assets/ff4cfa20-4cd4-4a81-ad71-f54ba8cc3e52)



### **-Comprobación**

Comprobamos que podemos acceder al sitio web, en modo no seguro, ahora para acceder al modo seguro tendremos que añadirle un dominio

Crearemos la base de datos dentro del wordpress

![image](https://github.com/user-attachments/assets/51baf8ef-b826-4e60-b86f-f88f638fa668)


![Captura de pantalla 2024-12-04 213228](https://github.com/user-attachments/assets/fc0ca817-b91f-44d4-bf30-0d2b6c79756b)



