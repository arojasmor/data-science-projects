# Ejercicios en SQL

En este proyecto me he dedicado a realizar diversos ejercicios con el lenguaje de consulta **SQL** con el único objetivo de demostrar mis habilidades con dicho lenguaje. Para lograr lo anterior, he utilizado dos IDEs: **MySQL** y **Jupyter Notebook**, éste último porque me apoyo en Python para realizar las consultas (utilizando el paquete **pymysql**) y sobre todo mostrar los resultados de cada query en forma de dataframe, pues éste diseño es más amigable de entender debido a que la salida que arroja Python después de ejecutar las consultas son listas de tuplas y, además, con un dataframe ya se puede trabajar utilizando, por ejemplo, Pandas para la manupulación y visualización de la información.

## 1 Distribuidor.ipynb
En el notebook Distribuidor, se hcen algunas consultas para analizar la información de una empresa ficticia denominada **Extreme Sports House**, distribuidor líder en equipo de montaña, senderismo y aventura. Se formularán y contestarán algunas preguntas de negocio, las más comunes que ayuden a generar insights. El propósito es simular las peticiones más comunes a un empleado de una área de analítica en una empresa. Las peticiones o solicitudes a las cuales se les da respuesta son:

 * ¿Cual ha sido la evolución mensual de la facturación por canal en los últimos 12 meses completos?
 * Localiza el nombre de nuestros 20 mejores clientes.
 * ¿Cuáles son los 25 productos en los que se obtiene un mayor margen financiero en cada línea de producto?
 * ¿Con qué productos necesitaríamos quedarnos para mantener el 90% de la facturación actual?
 * Y por tanto ¿Qué productos concretos podríamos eliminar y seguir manteniendo el 90% de la facturación?
 * ¿Cual es la contribución (en porcentaje) de cada línea de producto al total de facturación?
 * Dentro de la línea que más factura ¿Hay algún producto concreto que esté en tendencia? (Definimos tendencia como el crecimiento de Q2-2018 sobre Q1-2018).

## 2 Segmentacion_Clientes.ipynb
Este otro notebook, es la continuación del anterior, o sea, se trabaja con la misma base de datos que contiene información de la empresa ficticia **Extreme Sports House**. Igualmente, también se utilizan **MySQL** y **Jupyter Notebook**. Sin embargo, en esta ocasión el objetivo principal es hacer una **segmentación de clientes**, para categorizarlos e identificar quiénes son los mejores clientes y los que están comprando mucho pero gastando poco. Para lo anterior, se hara lo siguiente:

 * Crear una matriz de 4 segmentos en base al número de pedidos y la facturación de cada cliente.
 * CAlcular el potencial de desarrollo. Segmentar las tiendas por su tipo y calcular el percentil 75 (P75) de la facturación. Para cada tienda que esté por debajo del P75 calcular su potencial de desarrollo entendido esto como la diferencia entre la facturación del P75 y su facturación.
 * Reactivación de clientes. Identificar clientes que lleven más de 3 meses sin comprar (versus la última fecha disponible).

## 3 Sistema_recomendacion.ipynb
En este notebook presento la última parte relacionada con la misma base de datos y las mismas herramientas **MySQL** y **Jupyter Notebook**. En esta entrega hago un **sistema de recomendación** basado en frecuencias. Las tareas son:

 * Diseñar un sistema de recomendación item-item que localice aquellos productos que son comprados frecuentemente en el mismo pedido. Además, que se le pueda recomendar a cada cliente según su propio historial de productos comprados.
 * Crear una consulta que genere las recomendaciones para cada cliente en concreto y que sea capaz de eliminar los productos ya comprados por ese cliente.

<br/>
Espero que te resulten interesantes estos ejercicios!!!
