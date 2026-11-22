// uji_parsing_bucket_salah.flux  (bucket tidak ada)
from(bucket: "transport_db_belum_ada")
  |> range(start: 2026-11-01T00:00:00Z, stop: 2027-01-01T00:00:00Z)