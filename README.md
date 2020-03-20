# COVID-19 Análisis para Colombia

Giovany Babativa (@jgbabativam, gbabativam@usal.es)

Los resultados obtenidos en este informe están actualizados al: 19-03-2020


## Objetivo del recurso

Este recurso se hace con fines académicos y no tiene un propósito específico de explicar alguna metodología de análisis o modelo de datos. El código en R se deja abierto para generar transparencia de los resultados. Además el script de R puede ser utilizado en la academia por otros colegas o estudiantes que deseen replicar los resultados o hacer otros análisis a partir de los datos.

## Fuente de los datos

Los datos se toman del repositorio CSSE de la Universidad Johns Hopkins (https://systems.jhu.edu/) y pueden ser descargados de GitHub. 

Como se indica en la fuente, los datos se obtuvieron de la Organización Mundial de la Salud y de varias instituciones estatales de salud. Estos datos son propiedad de la Universidad John Hopkins y están disponibles solo para fines de investigación académica o enseñanza. Dado que los datos provienen de diferentes fuentes, no hay garantía de la precisión de los datos, por lo que es incorrecto utilizarlos con fines médicos o comerciales. Si se desea realizar un análisis de ese tipo por favor use las fuentes oficiales de cada país (https://github.com/CSSEGISandData/COVID-19). 

En el caso de los datos para Colombia, se toma la información reportada por el Instituto Nacional de Salud con corte a las 20:00 hrs de cada día, el cual se encuentra en https://www.ins.gov.co/Noticias/Paginas/Coronavirus.aspx. Para mayor información sobre el proceso de los datos se recomienda revisar el archivo COVID19Col.R.

## Advertencias

- Si usted decide compartir las imágenes obtenidas a partir de este  proceso de datos, asegúrese de que el enlace quede visible o comparta este link para que puedan acceder a estas advertencias. Evitemos al máximo el mal uso o mala interpretación.

- Tenga en cuenta que los datos no se expresan en tasas, así que se debe tener precaución en la interpretación del crecimiento del número de casos dado que el tamaño de la población en cada país es diferente.

- Los límites de los ejes varían dependiendo de cada gráfico por lo que tenga cuidado al realizar comparaciones apresuradas.

- Trate de enfocar sus opiniones hacía lo académico.

- Es posible que pueda encontrar errores. Si lo hace, por favor envíe un correo electrónico.

- Recuerde que este es un recurso académico, los análisis epidemiológicos son más complejos y dependen de diversos factores.

Finalmente recuerde que acá solo se comparan algunos de los países que me parecieron interesantes, bien sea por su cercanía con Colombia o por la velocidad de propagación que presentó, pero el repositorio cuenta con resultados para todos los países donde se han presentado casos. Si usted lo desea puede usar el código para agregar, retirar o simplemente analizar los países que prefiera.

## Comparaciones entre países

<image src="images/compara.png"> 
<image src="images/worldmap.png"> 

## Gráficos específicos para Colombia
