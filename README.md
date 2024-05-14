# InesData Local Environment

El entorno `InesData Local Environment` permite a los usuarios familiarizarse con el conector InesData. Mediante la ejecución del entorno local, los usuarios podrán conocer cómo funciona el conector de InesData así como comprobar cómo interactúan varios conectores entre sí.

## Componentes del entorno

A continuación se muestra un diagrama con los componentes que se ejecutan en el entorno local:

![Local Components](./docs/components.png)

## Ejecución del conector

Para ejecutar localmente el entorno se debe ejecutar el comando:

```
docker compose up
```

Se proporciona la colección [InesData Local Environment](resources/operations/InesData_Local_Environment.postman_collection.json) en formato Postman para realizar ejemplos de interacciones entre los conectores del entorno. 

**Nota:** Las transferencias de tipo `HttpProxy` enviarán la información para la descarga de Assets a través del servicio `http-proxy`. Este componente devuelve por consola las peticiones HTTP recibidas, incluídas las proporcionadas por los conectores con la información de descarga de los Assets. Si se quienres ver sus logs se debe ejecutar el comando 

```
docker compose logs -f http-proxy
```

## Interfaz de gestión de los conectores

Los conectores vienen con una interfaz de gestión en las siguientes direcciones:
- connector-c1: http://localhost:8001/inesdata-connector-interface
- connector-c2: http://localhost:8002/inesdata-connector-interface

## Administración

Las URLs de administración de MinIO son respectivamente:
- connector-c1: http://localhost:9001/browser
- connector-c2: http://localhost:9011/browser

Las conexiones a PostgreSQL se realizan mediante los datos:
- connector-c1: localhost:5432/inesdata
- connector-c2: localhost:5433/inesdata

Los usuarios se encuentran en el fichero [docker-compose.yml](docker-compose.yml)


## Hostnames

Los componentes que conforman el entorno local se comunican entre ellos a través de los nombres de host internos de Docker. Aunque casi todos son accesibles correctamente mediante `localhost`, hay una excepción que es `Keycloak`. Al acceder a la web de administración Keycloak intentará acceder al host configurado en la propiedad `KC_HOSTNAME`. La demo está preparada para funcionar tal cual está pero si se desea administrar Keyclpoak se debe añarir la siguiente regla al archivo `hosts` del sistema operativo:

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
