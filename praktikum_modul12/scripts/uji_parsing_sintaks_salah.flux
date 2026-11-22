// uji_parsing_sintaks_salah.flux  (nama fungsi salah ketik)
from(bucket: "transport_db")
  |> range(start: 2026-11-01T00:00:00Z, stop: 2027-01-01T00:00:00Z)
  |> filtr(fn: (r) => r._measurement == "trips")