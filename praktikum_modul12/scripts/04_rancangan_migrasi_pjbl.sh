#!/bin/bash
# 04_rancangan_migrasi_pjbl.sh  (rancangan, tanpa token asli)
docker exec influxdb2 influx bucket create --org kelompok_android --name energi_kampus
docker exec influxdb2 influx bucket list

# perangkat_pengukur: write-only
docker exec influxdb2 influx auth create --org kelompok_android --write-bucket <ID_BUCKET_ENERGI> --description "perangkat_pengukur"

# layanan_dashboard: read-only
docker exec influxdb2 influx auth create --org kelompok_android --read-bucket <ID_BUCKET_ENERGI> --description "layanan_dashboard"

# layar_ruangan: read-only (token terpisah)
docker exec influxdb2 influx auth create --org kelompok_android --read-bucket <ID_BUCKET_ENERGI> --description "layar_ruangan"