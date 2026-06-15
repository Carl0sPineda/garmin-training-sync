# Garmin Training Sync - Contexto para ChatGPT

## Objetivo

Estoy desarrollando un sistema que convierte planes de entrenamiento escritos en lenguaje natural a entrenamientos estructurados de Garmin Connect.

Cuando solicite sesiones o planes de entrenamiento, necesito que las entregues en un formato compatible con mi parser.

No necesito explicaciones técnicas dentro del bloque de entrenamiento. Solamente necesito el plan listo para copiar y pegar en `input_sesion.txt`.

---

# Estado actual del proyecto

Versión actual: v1.0

Funcionalidades implementadas:

* Running
* Cycling / MTB
* Pasos por tiempo
* Pasos por distancia
* Objetivos por ritmo (pace)
* Objetivos por frecuencia cardíaca (ppm)
* Objetivos por zonas cardíacas Garmin
* Repeticiones Garmin reales (Repeat Groups)
* Pasos hasta pulsar Lap
* Parser de lenguaje natural
* Múltiples entrenamientos por archivo
* Sincronización automática con Garmin Connect
* Prevención de duplicados

Funcionalidades pendientes:

* Interfaz gráfica (Streamlit)
* Multi-sport
* Comando único Generate + Sync
* Integración directa con ChatGPT

---

# Formato requerido

Cada entrenamiento debe seguir exactamente esta estructura:

```text
Fecha: YYYY-MM-DD
Nombre: Nombre del entrenamiento
Deporte: running | cycling

Sesión:
...
```

Si no se especifica el deporte, se asume:

```text
running
```

Si existen varios entrenamientos deben separarse mediante:

```text
---
```

Ejemplo:

```text
Fecha: 2026-07-01
Nombre: Mié01-Jul - Series

Sesión:
15 min calentamiento Z1
4 x 1 km @4:10-4:25 rec 2 min
10 min enfriamiento Z1

---
Fecha: 2026-07-04
Nombre: Sáb04-Jul - Easy Z2

Sesión:
45 min fácil Z2
```

---

# Sintaxis soportada

## Tiempo

```text
45 min
30 min suave
45 min fácil
45 min easy
```

## Distancia

```text
5 km
10 km
18 km
1.6 km
7.5 km
```

## Ritmo objetivo

Rango:

```text
10 km @5:20-5:50
```

Ritmo único:

```text
5 km @4:30
```

## Frecuencia cardíaca por zonas

```text
45 min Z2
30 min Z3
10 min calentamiento Z1
10 min enfriamiento Z1
```

## Frecuencia cardíaca por rango

```text
40 min FC 135-150
```

## Calentamiento

```text
15 min calentamiento
15 min calentamiento Z1
```

## Enfriamiento

```text
10 min enfriamiento
10 min enfriamiento Z1
```

---

# Repeticiones

Por distancia:

```text
4x1km @4:10-4:25 rec 2min
```

También:

```text
4 x 1 km @4:10-4:25 rec 2 min
```

Por tiempo:

```text
6x2min @4:20-4:40 rec 1min
```

---

# Recuperaciones con objetivo

Zona cardíaca:

```text
6x2min @4:20-4:40 rec 1min Z1
```

Frecuencia cardíaca:

```text
6x2min @4:20-4:40 rec 1min FC 120-135
```

Ritmo:

```text
6x2min @4:20-4:40 rec 1min @6:00-6:30
```

---

# Pulsación de botón Lap

## Paso individual

```text
hasta lap calentamiento al inicio de la cuesta
```

Genera:

```text
warmup
└─ hasta pulsar Lap
```

## Dentro de repeticiones

```text
5x3min @4:20-4:40 rec 2:30 lap
```

Genera:

```text
repeat x5
├─ run 3:00
├─ recovery 2:30
└─ run hasta pulsar Lap
```

Ideal para:

* Cuestas
* Trail running
* Segmentos con distancia variable
* Regreso al inicio de una cuesta

---

# Running

Ejemplo de rodaje Z2:

```text
Fecha: 2026-07-04
Nombre: Sáb04-Jul - Easy Z2

Sesión:
45 min fácil Z2
```

Ejemplo de series:

```text
Fecha: 2026-07-01
Nombre: Mié01-Jul - 4x1km

Sesión:
15 min calentamiento Z1
4 x 1 km @4:10-4:25 rec 2 min
10 min enfriamiento Z1
```

Ejemplo de tempo:

```text
Fecha: 2026-07-05
Nombre: Dom05-Jul - Tempo

Sesión:
10 min suaves
5 km @4:30
10 min suaves
```

Ejemplo de largo:

```text
Fecha: 2026-07-06
Nombre: Dom06-Jul - Largo

Sesión:
18 km @5:20-5:50
```

Ejemplo de cuestas:

```text
Fecha: 2026-07-09
Nombre: Jue09-Jul - Cuestas

Sesión:
hasta lap calentamiento al inicio de la cuesta
5x3min @4:20-4:40 rec 2:30 lap
10 min enfriamiento Z1
```

---

# Cycling / MTB

Ejemplo de MTB Z2:

```text
Fecha: 2026-07-12
Nombre: Dom12-Jul - MTB Z2
Deporte: cycling

Sesión:
10 min calentamiento Z1
60 min Z2
10 min enfriamiento Z1
```

Ejemplo de MTB Tempo:

```text
Fecha: 2026-07-19
Nombre: Dom19-Jul - MTB Tempo
Deporte: cycling

Sesión:
15 min calentamiento Z1
4x5min Z4 rec 3min Z1
10 min enfriamiento Z1
```

---

# Convenciones para ChatGPT

## Nombres

Los nombres deben ser cortos.

Ejemplos:

```text
Mié24-Jun - 4x1km
Sáb27-Jun - Z2
Dom28-Jun - Largo
Jue09-Jul - Cuestas
Dom12-Jul - MTB Z2
```

Evitar nombres excesivamente largos.

---

## Fechas

Siempre incluir la fecha exacta.

Nunca usar:

```text
Miércoles
Sábado
Domingo
Próxima semana
```

Siempre usar:

```text
Fecha: 2026-07-01
```

---

## Ritmos

Siempre utilizar:

```text
4:10
4:30
5:50
6:00
```

Nunca:

```text
4.10
4m10s
```

---

## Frecuencia cardíaca

Por zonas:

```text
Z1
Z2
Z3
Z4
Z5
```

Por rango:

```text
FC 135-150
```

---

# Perfil del atleta

Datos actuales:

* Edad: 33 años
* Peso: ~62 kg
* Garmin Forerunner 255
* VO2Max: ~50-53
* Umbral actual Garmin: 4:31/km
* FC Umbral: ~186 ppm
* HRV habitual: ~60-65 ms

Entrenamiento principal:

* Running
* Trail Running

Entrenamiento secundario:

* MTB recreativo

Disponibilidad habitual:

* Miércoles: sesión de calidad
* Sábado: rodaje fácil
* Domingo: tirada larga

Objetivos habituales:

* Trail Running
* 10K
* Media maratón
* Mejora de umbral
* Resistencia aeróbica

Condiciones habituales:

* Entrenamientos en Guanacaste
* Calor y humedad elevados
* Ajustar ritmos cuando la frecuencia cardíaca se eleve por condiciones climáticas

---

# Regla para generación de entrenamientos

Cuando se soliciten entrenamientos:

* Running → utilizar formato running compatible.
* MTB → utilizar `Deporte: cycling`.
* Mantener compatibilidad total con Garmin Training Sync.
* Utilizar únicamente sintaxis soportada por el parser.
* El bloque generado debe poder copiarse directamente a `input_sesion.txt`.

---

# Respuesta esperada

Cuando solicite una sesión o una semana de entrenamiento, devolver un bloque compatible con el parser.

El bloque debe venir en formato multilínea, listo para copiar directamente a `input_sesion.txt`.

Ejemplo:

```text
Fecha: 2026-07-01
Nombre: Mié01-Jul - Umbral

Sesión:
15 min calentamiento Z1
4 x 1 km @4:10-4:25 rec 2 min
10 min enfriamiento Z1

---
Fecha: 2026-07-04
Nombre: Sáb04-Jul - Easy

Sesión:
45 min fácil Z2

---
Fecha: 2026-07-05
Nombre: Dom05-Jul - Largo

Sesión:
18 km @5:20-5:50
```
## Importante sobre el formato
No entregar todo en una sola línea.
Mantener exactamente los saltos de línea.
No combinar Fecha, Nombre y Sesión en la misma línea.
Las explicaciones pueden ir fuera del bloque, pero el bloque debe poder copiarse directamente a `input_sesion.txt` sin modificaciones.

