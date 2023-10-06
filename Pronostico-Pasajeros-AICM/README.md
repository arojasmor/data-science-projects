# Pronóstico de Clientes en el Aeropuerto Internacional de la Ciudad de México

Este proyecto consistirá en **pronosticar la cantidad mensual de clientes del Aeropuerto Internacional de la Ciudad de México (AICM)**, es decir, se hará la predicción de los pasajeros que abordaron vuelos nacionales y vuelos internacionales, pero solo las salidas.

El periodo de tiempo abarca desde enero de 2008 a febrero de 2020, sin embargo, solo se utilizará el rango de 2008-2018 para entrenar el modelo y el año 2019 para validarlo. Por tanto, los siguientes dos periodos (enero y febrero de 2020), serán las observaciones a predecir. Lo anteior, debido a que estos meses no están afectados por la pandemia de Covid-19, pues en México inició el confinamiento a finales de marzo.

La información para este análisis es pública y los datos así como su descripción se encuentran en la página del [AICM](https://www.aicm.com.mx/estadisticas-del-aicm/17-09-2013). Es importante aclarar que los datos originales se encuentran dentro de informes en formato pdf, por lo que, para extraerlos se recurrió a la técnica conocida como **Reconocimiento Óptico de Caracteres (OCR).** Para el periodo 2012-2019, se utilizó R y para el resto del periodo 2008-2011 se utilizó Python, ya que ofreció los mejores resultados para esos años. Para los meses de enero y febrero de 2020 su captura fue manual.

Como este trabajo consistará en la creación de un **modelo de aprendizaje supervisado** para una serie de tiempo, la etapa del análisis exploratorio es un poco más densa que los análisis exploratorios descriptivos comunes. Esta etapa se constituye de las siguientes fases:

* Análisis visual
* Detección de outliers
* Correlogramas
* Descomposición de la serie
* Análisis de estacionariedad
* Detección de estacionalidad

Para obtener el modelo final se probaron varios modelos y se eligió el que generó el menor  **Mean Absolute Percentage Error (MAPE)**. Los algoritmos empleados fueron los siguientes:

* **ETS**: **E**xponen**T**ial **S**moothing
* **ARIMA**: **A**uto**R**egressive **I**ntegrated **M**oving **A**verage
* **TSLM**: **T**ime **S**eries **L**inear **M**odel
* **PROPHET**

Finalmente, se hizo un ensamble con los tres mejores modelos con el propósito de disminuir el MAPE.






