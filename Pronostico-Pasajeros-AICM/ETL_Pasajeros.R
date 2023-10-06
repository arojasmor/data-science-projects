
#############################################################################################

# codigo para generar la data de Salidas (Pasajeros) Nacionales 2008-2019

# https://www.aicm.com.mx/estadisticas-del-aicm/17-09-2013

#############################################################################################


library(tidyverse)
library(tesseract)
library(stringr)
library(lubridate)



ruta_imagen <- "Doc1_2018_2019.pdf"

tabla1 <- ocr(ruta_imagen)
tabla1

# reemplaza / con 7
tabla1 <- str_replace_all(tabla1, "[/(]", "7")
tabla1

# quitamos puntuación
lista <- str_replace_all(tabla1, "[[:punct:]]", "")
lista

# quitamos caracteres espaciales
lista <- str_replace_all(lista, "[~, |, =]", " ")
lista

# Separamos el texto en los diferentes elementos, genera una lista
lista <- str_split(lista, "\n")
lista

# ---------------------------------------- VARIA
# Extraemos la parte de los datos
lista <- lista[[1]][1:12]
lista



### ===> 2016-2017: Extraemos la parte de los datos
lista <- lista[[1]][-2]
lista <- lista[1:12]
lista


# quitamos los dobles espacios
lista <- gsub("  ", " ", lista)
lista <- gsub("  ", " ", lista)
lista

#------------------------   CASOS POR PDF ---------------------------------

# 2018-2019: Arreglamos los números pegados y el digito que falta
lista[2] <- str_replace(lista[2], "1094262", "1094282")
lista[4] <- str_replace(lista[4], "136572", "1365772")
lista[4] <- str_replace(lista[4], "669896", "669898")
lista[5] <- str_replace(lista[5], "696130", "695130")
lista[6] <- str_replace(lista[6], "1372029773923", "1372029 773923")
lista[9] <- str_replace(lista[9], "674856", "674858")
lista

# 2012-2013: Arreglamos los números pegados y el digito que falta
lista[2] <- str_replace(lista[2], "20677077", "2067707")
lista[8] <- str_replace(lista[8], "5027677", "502767")
lista



#---------------------------------------------------------

# Extraemos los componentes de cada linea
separo <- str_split(lista, " ", simplify = T)

# convertimos a dataframe
separo <- as.data.frame(separo)

# cambiamos los tipos a numericos
separo <- separo %>% 
  mutate(across(where(is.character), as.integer))

separo



## ===> se crea un data frame vacio (solo se ejecuta 1 vez para ir agregando la data)
df <- data.frame(Anio = numeric(),
                 Mes = numeric(),
                 Salidas = numeric()
)


for(i in 2018){
  
  # se forman las bases por año
  t1 <- separo %>% 
    select(V2, V4) %>%
    mutate(Anio = rep(i, 12),
           Mes = rep(1:12),
           Salidas = V2 + V4) %>% 
    select(-c(V2, V4))
  
  t2 <- separo %>% 
    select(V7, V9) %>%
    mutate(Anio = rep(i+1, 12),
           Mes = rep(1:12),
           Salidas = V7 + V9) %>% 
    select(-c(V7, V9))
  
  # se crea la base final
  df <- rbind(df, t1, t2)
}


rm(separo, t1, t2, i, lista, ruta_imagen, tabla1)



#---------A PARTIR DE 2011 SE HACE CON PYTHON (PDF individual)
# ya se trabajo con python y el paquete OpenCv


## ===> se crea un data frame vacio (solo se ejecuta 1 vez para ir agregando la data)
dfc <- data.frame(Anio = numeric(),
                  Mes = numeric(),
                  Salidas = numeric()
)


t1 <- read_csv("P_2008.csv")
t1

df2 <- t1 %>% 
  mutate(
    Anio = V1,
    Mes = V2,
    Salidas = V4 + V6
  ) %>% 
  select(Anio, Mes, Salidas)


dfc <- rbind(dfc, df2)

rm(t1, df2)



# juntamos las dos partes

pasajeros <- rbind(df, dfc)


# creamos la columna fecha y depuramos

pasajeros <- pasajeros %>% 
  arrange(Anio) %>% 
  mutate(Fecha = make_date(Anio, Mes, 01)) %>% 
  select(Fecha, Salidas)


# guardamos la base final

write_csv(x = pasajeros, file = "Salidas_Nacionales.csv", col_names = T)



