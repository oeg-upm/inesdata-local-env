# INESData Local Environment

El entorno `INESData Local Environment` permite a los usuarios familiarizarse con el conector INESData. Mediante la
ejecución del entorno local, los usuarios podrán conocer cómo funciona el conector de InesData así como comprobar cómo
interactúan varios conectores entre sí.

## Componentes del entorno

A continuación se muestra un diagrama con los componentes que se ejecutan en el entorno local:

![Local Components](./docs/inesdata-local-env.svg)

## Pre requisitos

Un entorno Linux con Docker y Docker compose instalados.

## Ejecución del entorno de pruebas

Para ejecutar localmente el entorno se debe ejecutar el script `generate-env.sh`  o `generate-env.ps1` (Powershell) que generará un archivo .env con
valores autogenerados para los secretos y tokens. 

```
generate-env.sh
```
o
```
generate-env.ps1
```

Una vez hecho esto, se puede llamar a `docker compose up` para levantar el entorno.

```
docker compose up
```

Se proporciona la colección [INESData Local
Environment](resources/operations/InesData_Local_Environment.postman_collection.json) en formato Postman para realizar
ejemplos del ciclo de vida de creación y compartición de datos entre los conectores del entorno. Además, se dispone de la colección [INESData Connector Management](resources/operations/InesData_Connector_Management_API.postman_collection.json) en formato Postman para mostrar las principales operaciones del API de INESData para gestionar las diferentes entidades disponibles.

## Interfaz de gestión de los conectores

Los conectores vienen con una interfaz de gestión en las siguientes direcciones:
- connector-c1: http://localhost:8001/inesdata-connector-interface
- connector-c2: http://localhost:8002/inesdata-connector-interface

## Administración

Los usuarios para poder identificarse en los diferentes entornos se encuentran en el fichero [docker-compose.yml](docker-compose.yml).

### Minio

Las URLs de administración de MinIO son respectivamente:
- connector-c1: http://localhost:9001/browser
- connector-c2: http://localhost:9011/browser

### PostgreSQL

Las conexiones a PostgreSQL se realizan mediante la cadena de conexión:
```
localhost:5432/<nombre_bd>
```

donde <nombre_bd> es el nombre de la BD de cada componente que requiere una (keycloak, strapi y ambos conectores).
Revisar el fichero [docker-compose.yml](docker-compose.yml) para más información sobre estos parámetros.

### Vault (Gestor de secretos)

La URL del gestor de secretos es la siguiente:
- localhost:8201

### Backend CMS (Strapi)

La URL de administración de Strapi es la siguiente:
- http://localhost:1337/admin

El usuario administrador se creará en el primer acceso a la aplicación.

### Portal público

La URL del portal público es la siquiente:
- http://localhost/

Para visualizar correctamente esta página es necesario hacer lo siguiente:
- Crear una instancia del tipo de contenido Landing Page en public-portal-backend: Content Manager > Landing Page. Guardar y publicar el contenido.
- Dar permiso de visualización en la API sobre el contenido que previamente se ha creado: Settings > Users & Permissions Plugin > Roles > Public > Permissions > Landing-page. Habilitar el checkbox "find".
- Dar permiso para obtener el catálogo federado: Settings > Users & Permissions Plugin > Roles > Public > Permissions > Get-federated-catalog. Habilitar el checkbox "getFederatedCatalog".
- Dar permiso para obtener los vocabularios: Settings > Users & Permissions Plugin > Roles > Public > Permissions > Get-vocabularies. Habilitar el checkbox "getVocabularies".

Para crear nuevas secciones de menú y asociar contenido a estos, hay que seguir los siguientes pasos en Strapi:
- Crear un nuevo contenido de tipo "Generic Page". El contenido HTML incrustado en este contenido puede romper estilos u otros componentes del portal público.
- Accecer a Menus. Crear nuevo menú, cuyo title y slug deberá tener el siguiente valor: "public-portal-menu".
- Añadir nuevo menu item y rellenar los siguientes campos:
  - Title: Texto que aparecerá en el front-end
  - URL: Enlace externo. Solo rellenar cuando no se asocie un contenido asociado en Strapi.
  - Target: Ventana de destino
  - Text for URL: El texto que aparecerá en la URL (solo para contenido asociado).
  - Relation (En la pestaña content): Añadir el contenido de tipo "Generic Page" creado anteriormente.
- Guardar los cambios.
- Dar permiso de visualización en la API sobre el tipo de contenido "Generic Page": Settings > Users & Permissions Plugin > Roles > Public > Permissions > Generic-page. Habilitar los checkbox "find" y "findOne".
- Dar permiso sobre los menus: Settings > Users & Permissions Plugin > Roles > Public > Permissions > Menus. Habilitar los checkbox "find" (para Menu y Menu-Item) y "findOne" (para Menu-Item).

## Hostnames

Los componentes que conforman el entorno local se comunican entre ellos a través de los nombres de host internos de Docker. Aunque casi todos son accesibles correctamente mediante `localhost`, hay una excepción que es `Keycloak`. Para poder acceder correctamente a la autorización de los portales de gestión de los conectores (inesdata-connector-interface) así como para acceder a la web de administración, Keycloak intentará acceder al host configurado en la propiedad `KC_HOSTNAME`. Se debe añarir la siguiente regla al archivo `hosts` del sistema operativo:

```
## INESDATA
127.0.0.1          keycloak
```

## Usuarios de Keycloak

Los usuarios incluidos en el entorno local son (misma contraseña y nombre de usuario):
- user-c1
  - Username: user-c1
  - Email: user-c1@dataspace.com
  - First name: user-c1
  - Last name: user-c1
  - region: eu
  - Groups: connector-c1
- user-c2
  - Username: user-c2
  - Email: user-c2@dataspace.com
  - First name: user-c2
  - Last name: user-c2
  - region: eu
  - Groups: connector-c2


## Disclaimer

Este trabajo ha recibido financiación del proyecto INESData (Infraestructura para la INvestigación de ESpacios de DAtos distribuidos en UPM), un proyecto financiado en el contexto de la convocatoria UNICO I+D CLOUD del Ministerio para la Transformación Digital y de la Función Pública en el marco del PRTR financiado por Unión Europea (NextGenerationEU)