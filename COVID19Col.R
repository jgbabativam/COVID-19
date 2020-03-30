#####.... Programado por Giovany Babativa
options(stringsAsFactors=FALSE)
library(tidyverse)
library(maps)
library(ggthemes)
library(lubridate)
library(ggpubr)
library(ggrepel)

url <- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/"

#......

confirmados <- read.csv(paste0(url, "time_series_covid19_confirmed_global.csv")) %>%
               pivot_longer(-c("Province.State", "Country.Region", "Lat", "Long"), 
                            names_to = "fecha", values_to = "nro_confirmados") %>%    
               separate(fecha, c("mes", "dia", "anno"), sep = "\\.") %>%                
               mutate(mes = gsub("X", "", mes),
                      anno = paste0("20", anno),
                      fecha = lubridate::date(paste(anno, mes, dia, sep = "-")) ) %>%   
               dplyr::select(Country.Region, Province.State, Lat, Long, fecha, nro_confirmados)   


muertos  <- read.csv(paste0(url, "time_series_covid19_deaths_global.csv")) %>%
            pivot_longer(-c("Province.State", "Country.Region", "Lat", "Long"), 
                         names_to = "fecha", values_to = "nro_muertos") %>%
            separate(fecha, c("mes", "dia", "anno"), sep = "\\.") %>%
            mutate(mes = gsub("X", "", mes),
                   anno = paste0("20", anno),
                   fecha = lubridate::date(paste(anno, mes, dia, sep = "-")) ) %>%
            dplyr::select(Country.Region, Province.State, Lat, Long, fecha, nro_muertos)


## El repositorio ha dejado de actualizar esta informacion
recuperados <- read.csv(paste0(url, "time_series_19-covid-Recovered.csv")) %>%
               pivot_longer(cols = matches("^X[0-9]{1,2}"), names_to = "fecha", values_to = "nro_recuperados") %>%
               separate(fecha, c("mes", "dia", "anno"), sep = "\\.") %>%
               mutate(mes = gsub("X", "", mes),
                      anno = paste0("20", anno),
                      fecha = lubridate::date(paste(anno, mes, dia, sep = "-")) ) %>%
               dplyr::select(Country.Region, Province.State, Lat, Long, fecha, nro_recuperados)

total <- full_join(confirmados, muertos,  
                   by = c("Country.Region", "Province.State", "Lat", "Long", "fecha")) #%>% 
         #left_join(recuperados, by = c("Country.Region", "Province.State", "Lat", "Long", "fecha"))



## https://www.ins.gov.co/Noticias/Paginas/Coronavirus.aspx   corte 20:00 hrs
total[total$Country.Region=="Colombia" & total$fecha=="2020-03-17", "nro_confirmados"] <- 75 
total[total$Country.Region=="Colombia" & total$fecha=="2020-03-18", "nro_confirmados"] <- 102
total[total$Country.Region=="Colombia" & total$fecha=="2020-03-19", "nro_confirmados"] <- 128
total[total$Country.Region=="Colombia" & total$fecha=="2020-03-20", "nro_confirmados"] <- 175
total[total$Country.Region=="Colombia" & total$fecha=="2020-03-21", "nro_confirmados"] <- 210
total[total$Country.Region=="Colombia" & total$fecha=="2020-03-22", "nro_confirmados"] <- 235
total[total$Country.Region=="Colombia" & total$fecha=="2020-03-23", "nro_confirmados"] <- 306
total[total$Country.Region=="Colombia" & total$fecha=="2020-03-24", "nro_confirmados"] <- 378
total[total$Country.Region=="Colombia" & total$fecha=="2020-03-25", "nro_confirmados"] <- 470
total[total$Country.Region=="Colombia" & total$fecha=="2020-03-26", "nro_confirmados"] <- 491
total[total$Country.Region=="Colombia" & total$fecha=="2020-03-27", "nro_confirmados"] <- 539
total[total$Country.Region=="Colombia" & total$fecha=="2020-03-28", "nro_confirmados"] <- 608
total[total$Country.Region=="Colombia" & total$fecha=="2020-03-29", "nro_confirmados"] <- 702
## Muertes
total[total$Country.Region=="Colombia" & total$fecha=="2020-03-23", "nro_muertos"] <- 3
total[total$Country.Region=="Colombia" & total$fecha=="2020-03-24", "nro_muertos"] <- 3
total[total$Country.Region=="Colombia" & total$fecha=="2020-03-25", "nro_muertos"] <- 4
total[total$Country.Region=="Colombia" & total$fecha=="2020-03-26", "nro_muertos"] <- 6
total[total$Country.Region=="Colombia" & total$fecha=="2020-03-27", "nro_muertos"] <- 6
total[total$Country.Region=="Colombia" & total$fecha=="2020-03-28", "nro_muertos"] <- 6
total[total$Country.Region=="Colombia" & total$fecha=="2020-03-29", "nro_muertos"] <- 10
#Recuperados

total$nro_recuperados <- 0  #Temporal solo para Colombia
total[total$Country.Region=="Colombia" & total$fecha=="2020-03-23", "nro_recuperados"] <- 6
total[total$Country.Region=="Colombia" & total$fecha=="2020-03-24", "nro_recuperados"] <- 6
total[total$Country.Region=="Colombia" & total$fecha=="2020-03-25", "nro_recuperados"] <- 8
total[total$Country.Region=="Colombia" & total$fecha=="2020-03-26", "nro_recuperados"] <- 8
total[total$Country.Region=="Colombia" & total$fecha=="2020-03-27", "nro_recuperados"] <- 10
total[total$Country.Region=="Colombia" & total$fecha=="2020-03-28", "nro_recuperados"] <- 10
total[total$Country.Region=="Colombia" & total$fecha=="2020-03-29", "nro_recuperados"] <- 10

total[total$Country.Region=="Chile" & total$fecha=="2020-03-19", "nro_confirmados"] <- 342

###---- Análisis de los días desde el brote

paises <- c("Argentina", "Brazil" ,"Colombia", "Ecuador", "Chile", "Spain", "Italy")

diasv <- total %>% 
            dplyr::filter(Country.Region %in% paises  & nro_confirmados > 0) %>% 
            group_by(Country.Region) %>% 
            mutate(dias = row_number()) %>% 
            ungroup()

diasv$newcases <-  with(diasv, ifelse(dias == 1, nro_confirmados, nro_confirmados - lag(nro_confirmados)))

fecha <- total %>% 
         dplyr::filter(fecha == lubridate::today()-1 & nro_confirmados > 0)

#### Graficas comparativas
rday <- max(diasv[diasv$Country.Region=="Brazil", "dias"])
paleta <- c("#73ACDF", "darkgreen","blue", "red", "purple", "darkgray", "#FFC30F")

ver <- diasv %>% 
       dplyr::filter(dias <= rday)

vmax <- max(ver$nro_confirmados)
cmax <- max(ver$newcases)

g1 <- diasv %>% 
        ggplot(aes(x = dias, y = nro_confirmados, colour = Country.Region), size = 1.5, alpha = .9) + 
        geom_line(size = 1.2, alpha = .9) +
        scale_colour_manual(values = paleta) +
        scale_x_continuous(breaks = seq(from = 0, to=180, by = 4)) +
        scale_y_continuous(breaks = seq(from = 0, to=90000, by = 3000)) +
        xlab("días transcurridos desde el caso 1")+
        ylab("Número de casos") +
        labs(title="Número de casos confirmados",
             caption= paste0("Fuente: repositorio CSSE - Universidad Johns Hopkins. Fecha de corte: ", Sys.Date()-1))+
        theme_bw() + theme(legend.key = element_blank(), legend.title = element_blank())

g2 <-  diasv %>% 
        ggplot(aes(x = dias, y = nro_confirmados, colour = Country.Region), size = 1.5, alpha = .9) + 
        geom_line(size = 1.2, alpha = .9) +
        geom_text_repel(data = dplyr::filter(diasv, fecha == lubridate::today()-1), aes(x = dias, y = nro_confirmados, label = nro_confirmados), size=3.5, segment.color = "grey50", arrow = arrow(length = unit(0.03, "npc"), type = "closed", ends = "first"), hjust=1.0)+
        scale_colour_manual(values = paleta) +
        xlab("días transcurridos desde el caso 1")+
        ylab("Casos confirmados") +
        labs(title=paste0("Evolución durante los primeros ", rday," días"))+
        xlim(0, rday + 1) +
        ylim(0, vmax+5) +
        theme_bw() + theme(legend.key = element_blank(), legend.title = element_blank(), legend.position = "none")


g3 <-  diasv %>% 
        ggplot(aes(x = dias, y = newcases, colour = Country.Region), size = 1.5, alpha = .9) + 
        geom_line(size = 1.0, alpha = .9) +
        geom_text_repel(data = dplyr::filter(diasv, fecha == lubridate::today()-1), aes(x = dias, y = newcases, label = newcases), size=3.5, segment.color = "grey50", arrow = arrow(length = unit(0.03, "npc"), type = "closed", ends = "first"), hjust=1.0)+
        scale_colour_manual(values = paleta) +
        xlab("días transcurridos desde el caso 1")+
        ylab("Nuevos casos") +
        labs(title="Nuevos casos por día",
             caption="@jgbabativam, detalles en https://github.com/jgbabativam/COVID-19")+
        xlim(0, rday+1) + ylim(0, cmax+5) +
        theme_bw() + theme(legend.key = element_blank(), legend.title = element_blank(), legend.position = "none") 

ggsave(file = "./images/compara.png", 
ggarrange(g1, ggarrange(g2, g3, ncol=1), ncol=2, common.legend = TRUE, legend = "top"),
width = 12, height = 8, dpi = 100, units = "in", device='png')


## Mapa

mundo <- ggplot() +
          borders("world", colour = "gray85", fill = "gray80") +
          theme_map()

ggsave(file = "./images/worldmap.png", mundo +
        geom_point(aes(x = Long, y = Lat, size = nro_confirmados), data = fecha, alpha = .5, color="red") +
        scale_size(range=c(2, 12)) +
        labs(title = paste0("Casos confirmados COVID-19 al ", lubridate::today()-1), size = 'Confirmados', caption = "@jgbabativam") +
        theme(plot.caption = element_text(hjust = 0, color="gray40", size=15)), 
width = 12, height = 8, dpi = 100, units = "in", device='png')


##### Comparacion mundial, America del sur y Colombia
PobMund <- 7637813000/1000000    # por 1.000.000, fuente; https://www.census.gov/popclock/world
PobAmeS <-  425102561/1000000    # por 1.000.000, fuente: https://es.wikipedia.org/wiki/Anexo:Pa%C3%ADses_de_Am%C3%A9rica_del_Sur_por_poblaci%C3%B3n
PobColb <-   50372424/1000000    #Proyecciones DANE 2020

AggWorld <- total %>% 
            group_by(fecha) %>% 
            summarise(confirmados = sum(nro_confirmados)) %>% 
            mutate(geo = "1. Mundo", dia = row_number(), 
                   Tasa = round(confirmados / PobMund, 1)) # por cada 1.000.000 habitantes

SurAmer <- c("Brazil", "Colombia", "Argentina", "Peru", "Venezuela", "Chile", 
             "Ecuador", "Bolivia", "Paraguay", "Uruguay")

AggAmer <- total %>% 
            dplyr::filter(Country.Region %in% SurAmer) %>% 
            group_by(fecha) %>% 
            summarise(confirmados = sum(nro_confirmados)) %>% 
            dplyr::filter(confirmados >0) %>% 
            mutate(geo = "2. América del Sur", dia = row_number(), 
                   Tasa = round(confirmados / PobAmeS, 1)) # por cada 1.000.000 habitantes

AggColb <- total %>% 
            dplyr::filter(Country.Region == "Colombia" & nro_confirmados >0) %>% 
            group_by(fecha) %>% 
            summarise(confirmados = sum(nro_confirmados)) %>% 
            mutate(geo = "3. Colombia", dia = row_number(), 
                   Tasa = round(confirmados / PobColb, 1)) # por cada 1.000.000 habitantes

Aggs <- rbind(AggWorld, AggAmer, AggColb)
rm(AggWorld, AggAmer, AggColb)


a1 <-  Aggs %>% 
        ggplot(aes(x = dia, y = Tasa, colour = geo), size = 1.5, alpha = .9) + 
        geom_point(aes(shape = geo), size = 2.5) +
        geom_line(size = 1.2, alpha = .9) +
        geom_text_repel(data = dplyr::filter(Aggs, dia >  12), aes(x = dia, y = Tasa, label = Tasa), size=3.5, hjust=1.0)+
        scale_colour_manual(values = c("darkgreen", "#3333FF", "darkorange")) +
        scale_x_continuous(breaks = seq(from = 0, to=60, by = 2)) +
        geom_hline(yintercept = 10, color = "black", linetype = 2) +
        geom_hline(yintercept = 20, color = "black", linetype = 2) +
        geom_hline(yintercept = 30, color = "black", linetype = 2) +
        xlab("días transcurridos desde que se detectó el primer caso en cada subpoblación")+
        ylab("Confirmados x cada millón de habitantes") +
        labs(title=paste0("Tasa diaria de confirmados por cada millón de habitantes"),
             caption = paste0("Fuente: repositorio CSSE - Universidad Johns Hopkins, census.gov. Fecha de corte: ", Sys.Date()-1, ". @jgbabativam, consulte detalles: https://github.com/jgbabativam/COVID-19"))+
        theme_classic() + theme(legend.title = element_blank(), legend.position = "bottom")

ggsave(file = "./images/TasaContagio.png", a1,
       width = 12, height = 8, dpi = 100, units = "in", device='png')
