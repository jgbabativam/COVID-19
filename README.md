# COVID-19 Análisis para Colombia

Giovany Babativa (@jgbabativam, gbabativam@usal.es)

Los resultados obtenidos en este informe están actualizados al: 19-03-2020


## Objetivo del recurso

Este recurso se hace solo con fines académicos, en ningún momento se espera que genere una sensación de pánico sino por el contrario se espera generar conciencia en la población sobre la importacia de respetar y seguir las recomendaciones sanitarias y de aislamiento.

Aunque no se usa con un propósito específico de explicar alguna metodología para el análisis o modelo de datos, el código en R se deja abierto para generar un proceso transparente. 

En general considero que cualquier explicación sobre los modelos estadísticos puede ser mejor entendida por los estudiantes cuando se aplica en un escenario cercano para todos, así que si lo desean el código de R puede ser utilizado en la academia por otros colegas y estudiantes para replicar los resultados o hacer otros análisis. De igual manera, son bienvenidas todas las sugerencias sobre los análisis específicos que se presentan acá.

## Fuente de los datos

Los datos se toman del repositorio CSSE de la Universidad Johns Hopkins (https://systems.jhu.edu/) y que pueden ser descargados de GitHub. 

Como se indica en la fuente, los datos se obtuvieron de la Organización Mundial de la Salud y de muchas instituciones estatales de salud. Estos datos son propiedad de la Universidad John Hopkins y están disponibles solo para fines de investigación académica y educativa.  Dado que los datos provienen de diferentes fuentes, no hay garantía de la precisión de los datos.  Es absolutamente incorrecto utilizarlo con fines médicos o comerciales. Si se desea realizar un análisis específico por favor use las fuentes oficiales de cada país (https://github.com/CSSEGISandData/COVID-19). 

En el caso de los datos para Colombia, el mismo se actualiza con la información reportada por el Instituto Nacional de Salud con corte a las 20:00 hrs de cada día, tomando el dato de https://www.ins.gov.co/Noticias/Paginas/Coronavirus.aspx. Para mayor información sobre el proceso de datos se recomienda revisar el archivo COVID19Col.R.

## Advertencias

- Si usted decide compartir las imágenes obtenidas a partir de este  análisis, asegúrese de que el enlace quede visible o comparta este link. Evitemos al máximo el mal uso o mala interpretación.

- Tenga en cuenta que los datos no se expresan en tasas, así que se debe tener precaución en la interpretación del crecimiento del número de casos dado que el tamaño de la población en cada país es diferente.

- Los límites de los ejes varían dependiendo de cada gráfico por lo que tenga cuidado al realizar comparaciones apresuradas.

- Trate de enfocar sus opiniones hacía lo académico.

- Es posible que pueda encontrar errores. Si lo hace, por favor envíe un correo electrónico.

- Recuerde que este es un recurso académico, los análisis epidemiológicos son más complejos y dependen de varios factores.

Finalmente recuerde que acá solo se comparan algunos países que en lo particular me parecieron interesantes bien sea por su cercanía con Colombia o por la velocidad de propagación que presentó, pero el repositorio cuenta con resultados para todos los países donde se han presentado casos. Si usted lo desea puede usar el código para agregar, retirar o simplemente analizar los países que prefiera.

