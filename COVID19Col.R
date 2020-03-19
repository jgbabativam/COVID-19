#####.... Programado por Giovany Babativa
library(tidyverse)
library(maps)
library(ggthemes)
library(lubridate)
library(ggpubr)

url <- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/"

#......

confirmados <- read.csv(paste0(url, "time_series_19-covid-Confirmed.csv")) %>%
               pivot_longer(-c("Province.State", "Country.Region", "Lat", "Long"), 
                            names_to = "fecha", values_to = "nro_confirmados") %>%    ## Reestructurar base de datos, columna con fecha 
               separate(fecha, c("mes", "dia", "anno"), sep = "\\.") %>%                   ## Separar la fecha para conformar una varaible de fecha
               mutate(mes = gsub("X", "", mes),
                      anno = paste0("20", anno),
                      fecha = lubridate::date(paste(anno, mes, dia, sep = "-")) ) %>%             ### Construcción de variable de fecha
                dplyr::select(Country.Region, Province.State, Lat, Long, fecha, nro_confirmados)   ### Dejar solo las variables de interés


muertos  <- read.csv(paste0(url, "time_series_19-covid-Deaths.csv")) %>%
            pivot_longer(-c("Province.State", "Country.Region", "Lat", "Long"), 
                         names_to = "fecha", values_to = "nro_muertos") %>%
            separate(fecha, c("mes", "dia", "anno"), sep = "\\.") %>%
            mutate(mes = gsub("X", "", mes),
                   anno = paste0("20", anno),
                   fecha = lubridate::date(paste(anno, mes, dia, sep = "-")) ) %>%
            dplyr::select(Country.Region, Province.State, Lat, Long, fecha, nro_muertos)


recuperados <- read.csv(paste0(url, "time_series_19-covid-Recovered.csv")) %>%
               pivot_longer(cols = matches("^X[0-9]{1,2}"), names_to = "fecha", values_to = "nro_recuperados") %>%
               separate(fecha, c("mes", "dia", "anno"), sep = "\\.") %>%
               mutate(mes = gsub("X", "", mes),
                      anno = paste0("20", anno),
                      fecha = lubridate::date(paste(anno, mes, dia, sep = "-")) ) %>%
               dplyr::select(Country.Region, Province.State, Lat, Long, fecha, nro_recuperados)


total <- full_join(confirmados, muertos,  
                   by = c("Country.Region", "Province.State", "Lat", "Long", "fecha")) %>% 
         full_join(recuperados, by = c("Country.Region", "Province.State", "Lat", "Long", "fecha"))


###---- Análisis de los días desde el brote

paises <- c("Argentina", "Brazil" ,"Colombia", "Ecuador", "Chile", "Spain", "Italy")

diasv <- total %>% 
            dplyr::filter(Country.Region %in% paises  & nro_confirmados > 0) %>% 
            group_by(Country.Region) %>% 
            mutate(dias = row_number()) %>% 
            ungroup()

## https://www.ins.gov.co/Noticias/Paginas/Coronavirus.aspx   corte 20:00 hrs
diasv[diasv$Country.Region=="Colombia" & diasv$fecha=="2020-03-17", "nro_confirmados"] <- 75 ## https://www.ins.gov.co/Noticias/Paginas/Coronavirus.aspx
diasv[diasv$Country.Region=="Colombia" & diasv$fecha=="2020-03-18", "nro_confirmados"] <- 102
diasv$newcases <-  with(diasv, ifelse(dias == 1, nro_confirmados, nro_confirmados - lag(nro_confirmados)))


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
        scale_y_continuous(breaks = seq(from = 0, to=60000, by = 2000)) +
        xlab("días transcurridos desde el caso 1")+
        ylab("Número de casos") +
        labs(title="Número de casos confirmados",
             caption= paste0("Fuente: repositorio CSSE - Universidad Johns Hopkins. Fecha de corte: ", Sys.Date()-1))+
        theme_bw() + theme(legend.key = element_blank(), legend.title = element_blank())

##.... Grafico recortado para ver algunos países de América del Sur.
g2 <-  diasv %>% 
        ggplot(aes(x = dias, y = nro_confirmados, colour = Country.Region), size = 1.5, alpha = .9) + 
        geom_line(size = 1.2, alpha = .9) +
        scale_colour_manual(values = paleta) +
        xlab("días transcurridos desde el caso 1")+
        ylab("Casos confirmados") +
        labs(title=paste0("Evolución durante los primeros ", rday," días"))+
        xlim(0, rday) + ylim(0, vmax) +
        theme_bw() + theme(legend.key = element_blank(), legend.title = element_blank(), legend.position = "none")


g3 <-  diasv %>% 
        ggplot(aes(x = dias, y = newcases, colour = Country.Region), size = 1.5, alpha = .9) + 
        geom_line(size = 1.0, alpha = .9) +
        scale_colour_manual(values = paleta) +
        xlab("días transcurridos desde el caso 1")+
        ylab("Nuevos casos") +
        labs(title="Nuevos casos por día",
             caption="@jgbabativam, detalles en https://github.com/jgbabativam/COVID-19")+
        xlim(0, rday) + ylim(0, cmax) +
        theme_bw() + theme(legend.key = element_blank(), legend.title = element_blank(), legend.position = "none") 

ggsave(file = "./images/compara.png", 
ggarrange(g1, ggarrange(g2, g3, ncol=1), ncol=2, common.legend = TRUE, legend = "top"),
width = 12, height = 8, dpi = 100, units = "in", device='png')

fecha <- total %>% 
         dplyr::filter(fecha == lubridate::today()-1 & nro_confirmados > 0)

%>% 
summary(fecha)
