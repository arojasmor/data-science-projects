# Segmentación de Clientes para Marketing

En este proyecto se hace una segmentación de clientes para una tienda de retail con el objetivo de generar información valiosa que apoye la toma de decisiones. La segmentación de clientes es de gran utilidad dentro de las empresas ya que permite agruparlos según las características que comparten, lo que a su vez permitirá, por ejemplo, al área de Marketing, diseñar campañas mejor focalizadas incrementando la probabilidad de éxito.

Desde saber qué productos comprar, cuántos de ellos y cuándo, hasta comercializar los productos correctos para los clientes correctos en el momento correcto son algunas de las ventajas de este tipo de análisis.

Los datos para este análisis provienen del repositorio de aprendizaje automático de [UC Irvine](https://archive.ics.uci.edu/ml/datasets/online+retail), que es un sitio web para la comunidad de machine learning, donde se pueden encontrar bases de datos para practicar data science.

El conjunto de datos a trabajar corresponden a todas las transacciones ocurridas entre el 01/12/2010 y el 09/12/2011 para un comercio minorista en línea en el Reino Unido.

El algoritmo utilizado para hacer la segmentación fue **k-means**, por ser rápido y fácil de ejecutar. Además, se implementaron las siguientes técnicas de análisis como apoyo para bajar aún más el análisis:

* **Árbol de decisión.**
* **Reglas de asociación.**

La información que tenemos está incompleta en el sentido de que no tenemos las categorías de los productos vendidos, pues solo contamos con su descripción, por lo tanto, para obtener información más útil y procesable, fue necesario conseguir dichas categorías, ya que éstas nos pueden proporcionar información muy relevante sobre qué tipo de productos suele comprar un cliente, por lo que, los datos se obtuvieron de una de las tiendas retail más populares a nivel mundial: [walmart](https://gecrm.my.salesforce.com/sfc/p/#61000000ZKTc/a/4M0000000OSs/Wmj3VYVcRE4fLTPw7XVhddGbyXeHQqI5A4wWjJIei5A)




