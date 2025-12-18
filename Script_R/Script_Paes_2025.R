library(dplyr)
library(ggplot2)

datos_Inscripcion <- read.csv2(
  "C:/Users/ngala/OneDrive/Desktop/Trabajo/ArchivoB_Adm2025.csv",
  stringsAsFactors = FALSE)
dim(datos_Inscripcion)

data_Puntajes <- read.csv2(
  "C:/Users/ngala/OneDrive/Desktop/Trabajo/ArchivoC_Adm2025.csv",
  stringsAsFactors = FALSE)
dim(data_Puntajes)


#personas que no rindieron el proceso anterior 
no_participa <- datos_Inscripcion %>% filter(RINDIO_PROCESO_ACTUAL==0 & RINDIO_PROCESO_ANTERIOR==0)
dim(no_participa)
no_participa

#Identificador de alumnos que no participaron el procero 2024-2025
IDs_No_participantes <- no_participa[, "ID_aux"]
IDs_No_participantes

#Eliminar las filas de las personas que no rindieron las pruebas
datos_Inscripcion_limpio <- datos_Inscripcion %>%
  filter(!ID_aux %in% IDs_No_participantes)
dim(datos_Inscripcion_limpio)

data_Puntajes_limpio <- data_Puntajes %>%
  filter(!ID_aux %in% IDs_No_participantes)
dim(data_Puntajes_limpio)

cols_pruebas <- c(
  "CLEC_REG_ACTUAL",
  "MATE1_REG_ACTUAL",
  "MATE2_REG_ACTUAL",
  "HCSOC_REG_ACTUAL",
  "CIEN_REG_ACTUAL",
  "CLEC_INV_ACTUAL",
  "MATE1_INV_ACTUAL",
  "MATE2_INV_ACTUAL",
  "HCSOC_INV_ACTUAL",
  "CIEN_INV_ACTUAL",
  
  "CLEC_REG_ANTERIOR",
  "MATE1_REG_ANTERIOR",
  "MATE2_REG_ANTERIOR",
  "HCSOC_REG_ANTERIOR",
  "CIEN_REG_ANTERIOR",
  "CLEC_INV_ANTERIOR",
  "MATE1_INV_ANTERIOR",
  "MATE2_INV_ANTERIOR",
  "HCSOC_INV_ANTERIOR",
  "CIEN_INV_ANTERIOR")


ptje_Pruebas <- c("ID_aux", cols_pruebas)

data_Puntajes_limpio[, ptje_Pruebas]


#Estudiantes que se inscribieron el proceso pero no rindieron las pruebas
IDs_todo_0_NA <- data_Puntajes_limpio %>%
  filter(
    rowSums(across(all_of(cols_pruebas), ~ is.na(.) | . == 0)) ==
      length(cols_pruebas)
  ) %>%
  select(ID_aux)

dim(IDs_todo_0_NA)
dim(data_Puntajes_limpio)
dim(datos_Inscripcion_limpio)

#El 10% del total de inscritos se ausento de las pruebas
34482/311066

###Exluyento del df los alumnos que no rindieron las pruebas###
Inscritos_Participantes <- datos_Inscripcion_limpio%>%
  filter(!ID_aux %in% IDs_todo_0_NA$ID_aux)
dim(Inscritos_Participantes)

Puntajes_Participantes <- data_Puntajes_limpio %>%
  filter(!ID_aux %in% IDs_todo_0_NA$ID_aux)
dim(Puntajes_Participantes)

hist(Puntajes_Participantes$MATE1_REG_ACTUAL)

Puntajes_Participantes

#Se Crearan las columnas Ptje_Lectura,Ptje_Mate1, Ptje_Mate2, Ptje_Historia, Ptje_Ciencias 
#para conservar los mejores puntajes independiente de la temporalidad
Puntajes_Participantes <- Puntajes_Participantes %>%
  mutate(
    PTJE_MATE1 = pmax(
      MATE1_REG_ACTUAL,
      MATE1_INV_ACTUAL,
      MATE1_REG_ANTERIOR,
      MATE1_INV_ANTERIOR,
      na.rm = TRUE
    )
  )

Puntajes_Participantes <- Puntajes_Participantes %>%
  mutate(
    PTJE_MATE2 = pmax(
      MATE2_REG_ACTUAL,
      MATE2_INV_ACTUAL,
      MATE2_REG_ANTERIOR,
      MATE2_INV_ANTERIOR,
      na.rm = TRUE
    )
  )

Puntajes_Participantes <- Puntajes_Participantes %>%
  mutate(
    PTJE_LECTURA = pmax(
      CLEC_REG_ACTUAL,
      CLEC_INV_ACTUAL,
      CLEC_REG_ANTERIOR,
      CLEC_INV_ANTERIOR,
      na.rm = TRUE
    )
  )

Puntajes_Participantes <- Puntajes_Participantes %>%
  mutate(
    PTJE_HISTORIA = pmax(
      HCSOC_REG_ACTUAL,
      HCSOC_INV_ACTUAL,
      HCSOC_REG_ANTERIOR,
      HCSOC_INV_ANTERIOR,
      na.rm = TRUE
    )
  )

Puntajes_Participantes <- Puntajes_Participantes %>%
  mutate(
    PTJE_CIENCIA = pmax(
      CIEN_REG_ACTUAL,
      CIEN_INV_ACTUAL,
      CIEN_REG_ANTERIOR,
      CIEN_INV_ANTERIOR,
      na.rm = TRUE
    )
  )

Puntajes_Participantes <- Puntajes_Participantes %>%
  select(
    -MATE1_REG_ACTUAL,
    -MATE1_INV_ACTUAL,
    -MATE1_REG_ANTERIOR,
    -MATE1_INV_ANTERIOR,
    -MATE2_REG_ACTUAL,
    -MATE2_INV_ACTUAL,
    -MATE2_REG_ANTERIOR,
    -MATE2_INV_ANTERIOR,
    -CLEC_REG_ACTUAL,
    -CLEC_INV_ACTUAL,
    -CLEC_REG_ANTERIOR,
    -CLEC_INV_ANTERIOR,
    -HCSOC_REG_ACTUAL,
    -HCSOC_INV_ACTUAL,
    -HCSOC_REG_ANTERIOR,
    -HCSOC_INV_ANTERIOR,
    -CIEN_REG_ACTUAL,
    -CIEN_INV_ACTUAL,
    -CIEN_REG_ANTERIOR,
    -CIEN_INV_ANTERIOR
  )

#Filtrar Data para solo alumnos que cumplen los criterios minimos de postulacion
Puntajes_Participantes <- Puntajes_Participantes %>% filter(PTJE_MATE1 > 0 & PTJE_LECTURA > 0)


hist(Puntajes_Participantes$PTJE_LECTURA)
dim(Puntajes_Participantes)
dim(Inscritos_Participantes)

intersect(colnames(Puntajes_Participantes),
          colnames(Inscritos_Participantes))

cols_repetidas <- intersect(colnames(Puntajes_Participantes),
                            colnames(Inscritos_Participantes))

cols_repetidas <- setdiff(cols_repetidas, "ID_aux")

Inscritos_Participantes_limpio <- Inscritos_Participantes %>%
  select(-all_of(cols_repetidas))

#SE Consolida una base de final para los alumnos inscritos y que rindieron todas las prubas obligatorias para postular 
Base_final <- inner_join(
  Puntajes_Participantes,
  Inscritos_Participantes_limpio,
  by = "ID_aux"
)

Base_final_RM <- Base_final %>% filter(CODIGO_REGION == 13)
dim(Base_final_Pte_Alto)

write.csv(
  Base_final_RM,
  "base_paes_limpia_RM.csv",
  row.names = FALSE
)

ggplot(Base_final, aes(x = factor(GRUPO_DEPENDENCIA), y = PTJE_NEM)) +
  geom_boxplot()

mean(Base_final$PTJE_NEM)


# Scatter plot básico
plot(
  x = Base_final$PTJE_NEM,
  y = Base_final$PTJE_LECTURA,
  xlab = "Puntaje NEM",
  ylab = "Puntaje PAES Lectura",
  main = "Relación entre NEM y Puntaje PAES Lectura",
  pch = 16,
  col = rgb(0.2, 0.5, 0.8, 0.4)
)


dim(Base_final_RM)
