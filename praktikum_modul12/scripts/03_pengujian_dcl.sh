===== Persiapan =====

# 1. Ambil ID bucket transport_db
docker exec influxdb2 influx bucket list

# 2. Buat token report_user (hanya baca)
docker exec influxdb2 influx auth create --org kelompok_android --read-bucket <ID_BUCKET_TRANSPORT_DB> --description "report_user"

# 3. Periksa hak akses (padanan SHOW GRANTS)
docker exec influxdb2 influx auth list

===== Pengujian dengan token report_user =====

# Uji A: baca
docker exec influxdb2 influx query --org kelompok_android --token <TOKEN_REPORT> --file /scripts/02_query_transportasi.flux

# Uji B: tulis
docker exec influxdb2 influx write --org kelompok_android --token <TOKEN_REPORT> --bucket transport_db --precision s --file /scripts/uji_write.lp

# Uji C: hapus
docker exec influxdb2 influx delete --org kelompok_android --token <TOKEN_REPORT> --bucket transport_db --start 2020-01-01T00:00:00Z --stop 2020-01-01T00:00:01Z

# Uji D: cabut izin (REVOKE) dengan menghapus token
docker exec influxdb2 influx auth delete --id <ID_TOKEN_REPORT>

# Ulangi Uji A dengan token yang sama
docker exec influxdb2 influx query --org kelompok_android --token <TOKEN_REPORT> --file /scripts/02_query_transportasi.flux

# Uji E: periksa lagi status hak akses
docker exec influxdb2 influx auth list

===== Opsional: operator_user (baca dan tulis) =====
docker exec influxdb2 influx auth create --org kelompok_android --read-bucket <ID_BUCKET_TRANSPORT_DB> --write-bucket <ID_BUCKET_TRANSPORT_DB> --description "operator_user"

# Uji B dengan token operator
docker exec influxdb2 influx write --org kelompok_android --token <TOKEN_OPERATOR> --bucket transport_db --precision s --file /scripts/uji_write.lp