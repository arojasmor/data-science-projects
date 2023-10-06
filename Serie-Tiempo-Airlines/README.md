PRONÓSTICO: SERIE DE TIEMPO AIRLINE PASSENGERS
<br>

![travel-5219496_1280](https://github.com/arojasmor/time-series/assets/66392256/6c2d8c00-a8c4-4967-ab8e-04d191af5a6c)


El presente proyecto consiste en analizar una serie de tiempo y realizar un pronóstico. Se aprovecha este tipo de series para
paracticar la imputación de valores faltantes así como el tratamiento de los llamados outliers. Para hacer el pronóstico se 
utiliza el modelo **ARIMA** (AutoRegressive Integrated Moving Average). La métrica de evaluación es el error porcentual 
absoluto medio (mape), sin embargo, se generarán más metricas con fines comparativos. Además, a cada modelo se le analizarán
sus residuales. Finalmente, para el modelo finalista se evaluarán los supuestos de normalidad, heterocedasticidad y autocorrelación.

El trabajo consta de las siguientes etapas:

* Set up.
* Carga de los datos.
* Detección de estacionariedad.
* Estacionalidad y tendencia.
* Creación del modelo.
* Validación de los supuestos.
* Estratégia de ensamble.
* Conclusiones.
