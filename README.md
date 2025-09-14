

# UF Watcher

Esta es una aplicación web en Ruby on Rails que permite consultar el valor de la Unidad de Fomento (UF) para una fecha específica o para el día actual, obteniendo los datos de la API de la CMF.

## Configuración para Ejecución Local

Para ejecutar esta aplicación en tu entorno local, es necesario configurar algunas variables de entorno esenciales, especialmente para la base de datos y la conexión a la API.

### Variables de Entorno

Debes crear un archivo .env en la raíz de tu proyecto para almacenar las siguientes variables de forma segura. Asegúrate de no subir este archivo a tu repositorio de Git.

`DATABASE_USERNAME=tu_usuario_de_postgresql`

`DATABASE_PASSWORD=tu_contraseña_de_postgresql`

`CMF_API_KEY=tu_clave_api_de_la_cmf`



Importante: Reemplaza los valores de ejemplo con tus credenciales y tu clave de API reales.

### Pasos para Iniciar la Aplicación

Una vez que hayas configurado el archivo .env, sigue estos pasos para levantar el proyecto:

#### Instalar las gemas:

`bundle install`

#### Crear y migrar la base de datos:

`rails db:create`

`rails db:migrate`

#### Para dejar corriendo el crontab 1 vez al día para recuperar el valor del día de la UF:

`whenever --update-crontab`


#### Iniciar el servidor de Rails:

`rails server`

La aplicación estará disponible en http://localhost:3000.