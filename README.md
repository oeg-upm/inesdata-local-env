# InesData Local Environment

El entorno `InesData Local Environment` permite a los usuarios familiarizarse con el conector InesData. Mediante la ejecución del entorno local, los usuarios podrán conocer cómo funciona el conector de InesData así como comprobar cómo interactúan varios conectores entre sí.

## Componentes del entorno

A continuación se muestra un diagrama con los componentes que se ejecutan en el entorno local:

![Local Components](./docs/components.png)

## Pre requisitos

Para poder ejecutar el entorno local de InesData se debe tener una imagen local del conector tageada como `inesdata/connector:0.1`. Para ello se deben seguir los siguientes pasos:

- Descargar el proyecto InesData Connector
- Seguir los pasos indicados en la documentación del repositorio para contenerizar el conector asegurándose que se genere el tage indicado con el modificador `--tag inesdata/connector:0.1`

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
