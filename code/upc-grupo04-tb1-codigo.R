# UPC Grupo 04 - TB1
# Limpieza y análisis exploratorio del dataset Hotel Bookings

# Paquetes
required <- c("readr", "dplyr", "ggplot2")
new <- required[!(required %in% installed.packages()[,"Package"])]
if(length(new)) install.packages(new)
library(readr)
library(dplyr)
library(ggplot2)

# Rutas
input_file <- "data/hotel_bookings_original.csv"
output_file <- "data/hotel_bookings_preparado.csv"
plot_dir <- "output/graficos"

if (!dir.exists(plot_dir)) dir.create(plot_dir, recursive = TRUE)

# 1. Importar
hotel <- read_csv(input_file, show_col_types = FALSE)

# 2. Revisión inicial
cat("Filas originales:", nrow(hotel), "\n")
cat("Columnas:", ncol(hotel), "\n")
print(colSums(is.na(hotel)))

# 3. Limpieza
hotel_preparado <- hotel %>%
  mutate(
    children = ifelse(is.na(children), 0, children),
    country = ifelse(is.na(country), "Unknown", country),
    agent = ifelse(is.na(agent), 0, agent),
    company = ifelse(is.na(company), 0, company)
  ) %>%
  distinct()

# Eliminar valores negativos que no son válidos para estas variables
hotel_preparado <- hotel_preparado %>%
  filter(
    lead_time >= 0,
    adr >= 0,
    stays_in_weekend_nights >= 0,
    stays_in_week_nights >= 0
  )

# 4. Exportar dataset preparado
write_csv(hotel_preparado, output_file)

cat("Filas finales:", nrow(hotel_preparado), "\n")
cat("Tasa de cancelación:", mean(hotel_preparado$is_canceled) * 100, "%\n")

# 5. Gráfica: reservas por hotel
g1 <- ggplot(hotel_preparado, aes(x = hotel)) +
  geom_bar() +
  labs(
    title = "Reservas por tipo de hotel",
    x = "Hotel",
    y = "Número de reservas"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(plot_dir, "01_reservas_por_hotel.png"),
  plot = g1, width = 9, height = 5, dpi = 160
)

# 6. Gráfica: cancelaciones
cancelaciones <- hotel_preparado %>%
  mutate(estado = ifelse(is_canceled == 1, "Cancelada", "No cancelada"))

g2 <- ggplot(cancelaciones, aes(x = estado)) +
  geom_bar() +
  labs(
    title = "Estado de cancelación de las reservas",
    x = "Estado",
    y = "Número de reservas"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(plot_dir, "02_cancelaciones.png"),
  plot = g2, width = 9, height = 5, dpi = 160
)

# 7. Gráfica: tasa de cancelación por hotel
tasa_hotel <- hotel_preparado %>%
  group_by(hotel) %>%
  summarise(tasa_cancelacion = mean(is_canceled) * 100)

g3 <- ggplot(tasa_hotel, aes(x = hotel, y = tasa_cancelacion)) +
  geom_col() +
  labs(
    title = "Tasa de cancelación por tipo de hotel",
    x = "Hotel",
    y = "Tasa de cancelación (%)"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(plot_dir, "03_tasa_cancelacion_hotel.png"),
  plot = g3, width = 9, height = 5, dpi = 160
)

# 8. Gráfica: lead time
g4 <- ggplot(hotel_preparado, aes(x = lead_time)) +
  geom_histogram(bins = 40) +
  labs(
    title = "Distribución del tiempo de anticipación",
    x = "Días de anticipación",
    y = "Frecuencia"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(plot_dir, "04_lead_time.png"),
  plot = g4, width = 9, height = 5, dpi = 160
)

cat("Proceso terminado.\n")
