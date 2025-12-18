# paes-brechas-puente-alto-2025
resultados PAES 2025 – Puente Alto

# Brechas en los Resultados PAES 2025 – Comuna de Puente Alto

## 🎯 Pregunta analítica
¿Qué brechas existen en los resultados de la PAES 2025 en la comuna de Puente Alto según el tipo de establecimiento educacional y el desempeño escolar previo de los estudiantes?

---

## 📊 Descripción del proyecto
Este proyecto analiza los resultados de la PAES 2025 en la comuna de Puente Alto utilizando datos públicos del DEMRE. El foco está en identificar brechas de desempeño académico asociadas al tipo de establecimiento educacional, al desempeño escolar previo (NEM) y a variables de contexto socioeconómico.

El análisis se apoya en un proceso reproducible de limpieza, integración y transformación de datos en R, y en un panel de visualización desarrollado en Looker Studio para comunicar los principales hallazgos.

---

## 📂 Fuentes de datos
Datos públicos del proceso de admisión a la educación superior (DEMRE):
- Inscripción al proceso de admisión
- Resultados PAES

Disponibles en:  
https://portal-transparencia.demre.cl/portal-base-datos

---

## 🧹 Proceso de limpieza y transformación de datos
El procesamiento de los datos incluye las siguientes etapas:

1. Eliminación de estudiantes que no rindieron la PAES ni en el proceso actual ni en el anterior.
2. Exclusión de registros sin puntajes válidos en ninguna prueba.
3. Construcción de puntajes finales por prueba, considerando el mejor resultado obtenido por cada estudiante, independiente del período de rendición.
4. Filtrado de estudiantes que cumplen los requisitos mínimos de postulación.
5. Integración de bases mediante un identificador único anonimizado (`ID_aux`).
6. Depuración de variables duplicadas y consolidación de una base final para análisis.

Todo el proceso está documentado y reproducible en el script en R incluido en este repositorio.

---

## 📈 Visualizaciones y métricas
El panel en Looker Studio incluye:
- Indicadores clave (promedios PAES, NEM, cantidad de estudiantes).
- Comparación de puntajes promedio por tipo de establecimiento.
- Distribución del desempeño PAES.
- Relación entre desempeño escolar previo (NEM) y resultados PAES mediante scatter plots.
- Análisis por tramos de notas y tipo de establecimiento.

---

## 🎨 Decisiones de diseño del panel
- Se priorizó claridad y simplicidad por sobre complejidad técnica.
- Se utilizaron métricas promedio para facilitar comparaciones.
- Se incorporaron filtros para explorar subgrupos de interés.
- El flujo del dashboard sigue una lógica: contexto general → comparación → relación entre variables.

---

## 🛠️ Herramientas utilizadas
- R (dplyr, ggplot2)
- Looker Studio

---

## 🔗 Panel de analítica
El panel público puede consultarse en el siguiente enlace:  
[Agregar aquí el link a Looker Studio]
