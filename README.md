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

Script de aprovisionamiento para los servidores web:

Script de aprovisionamiento para el NFS:

Script de aprovisionamiento para la base de datos:

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




