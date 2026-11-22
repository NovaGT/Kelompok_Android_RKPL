// uji_parsing_measurement_salah.flux  (bucket ada, measurement tidak ada)
from(bucket: "transport_db")
  |> range(start: 2026-11-01T00:00:00Z, stop: 2027-01-01T00:00:00Z)
  |> filter(fn: (r) => r._measurement == "trips_belum_ada")