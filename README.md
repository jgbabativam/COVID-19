# COVID-19: Descripción gráfica de la evolución en Colombia

Giovany Babativa (@jgbabativam, gbabativam@usal.es)

Los resultados obtenidos en este informe están actualizados al: 28-04-2020

## Objetivo del recurso

Este recurso se hace con fines académicos y no tiene un propósito específico de explicar alguna metodología de análisis o algún tipo de modelo de datos. El código en R se deja abierto para generar transparencia en el procesamiento de los datos y resultados. Este script puede ser utilizado en la academia por otros colegas o estudiantes que deseen replicar los resultados o hacer otros análisis a partir de los mismos.

## Fuente de los datos

Los datos se toman del repositorio CSSE de la Universidad Johns Hopkins (https://systems.jhu.edu/) y son descargados de GitHub. 

Como lo indica la fuente, estos datos se obtuvieron de la Organización Mundial de la Salud y de varias instituciones estatales de salud. Los datos son propiedad de la Universidad John Hopkins y están disponibles para fines de investigación académica o de enseñanza. Dado que los datos provienen de diferentes fuentes, no hay garantía de la precisión de los mismos, por lo que es incorrecto utilizarlos con fines médicos o comerciales. Si se desea realizar un análisis de ese tipo por favor use las fuentes oficiales de cada país (https://github.com/CSSEGISandData/COVID-19). 

En el caso de los datos para Colombia, la información se toma del reporte del Instituto Nacional de Salud con corte a las 20:00 hrs de cada día, el cual se encuentra en https://www.ins.gov.co/Noticias/Paginas/Coronavirus.aspx. Para mayor información sobre el proceso de los datos se recomienda revisar el archivo COVID19Col.R. 

Las tasas de confirmados fueron calculadas con base en la información poblacional del mundo reportada en la página www.census.gov, para el caso de los países de América del Sur se excluye a Guyana, Surinam y Guyana Francesa, la información se toma de este <a href="https://es.wikipedia.org/wiki/Anexo:Pa%C3%ADses_de_Am%C3%A9rica_del_Sur_por_poblaci%C3%B3n">enlace</a> donde además se comparó la cifra poblacional para Colombia con su fuente oficial del <a href="https://www.dane.gov.co/index.php/estadisticas-por-tema/demografia-y-poblacion/proyecciones-de-poblacion">DANE</a>.

## Advertencias

- Si usted decide compartir las imágenes obtenidas a partir de este  proceso de datos, asegúrese de que el enlace quede visible o comparta este link para que puedan acceder a estas advertencias. Evitemos al máximo el mal uso o mala interpretación.

- Tenga en cuenta que los datos no se expresan en tasas, así que se debe tener precaución en la interpretación del crecimiento del número de casos dado que el tamaño de la población en cada país es diferente.

- Los límites de los ejes varían dependiendo de cada gráfico por lo que tenga cuidado al realizar comparaciones apresuradas.

- Trate de orientar sus opiniones hacía lo académico.

- Es posible que pueda encontrar errores. Si lo hace, por favor envíe un correo electrónico a gbabativam@gmail.com.

- Recuerde que este es un recurso académico, los análisis epidemiológicos son más complejos y dependen de diversos factores.

Finalmente recuerde que acá solo se comparan algunos países que me parecieron interesantes, bien sea por su cercanía con Colombia o por la velocidad de propagación que presentó, pero el repositorio cuenta con resultados para todos los países donde se han presentado casos. Si usted lo desea puede usar el código para agregar, retirar o simplemente analizar los países que prefiera.

## Gráficos específicos para Colombia
Evolución de casos diarios confirmados por departamento:

<image src="images/EvolMapCol.gif"> 

Evolución epidemiológica nacional:

<image src="images/TendEpidMultivar.png"> 

Evolución de casos diarios confirmados a nivel nacional:

<image src="images/EvolCol.gif"> 
  
## Comparaciones entre países

<image src="images/compara.png"> 

El siguiente gráfico compara la tasa diaria de casos confirmados por cada millón de habitantes. La tasa se calcula con los casos confirmados en la región en la fecha determinada y se divide por el total poblacional de la región, ese resultado es multiplicado por un millón. Para ver los detalles consulte el script COVID19Col.R.

<image src="images/TasaContagio.png">

<image src="images/worldmap.png"> 