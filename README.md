# 開発環境起動

```bash
# mysql起動
./bin/mysqld.sh

# grafana起動
./bin/run.sh
```

http://localhost:3001/ にアクセス

- ID: `admin`
- PW: `tapioka!`

# デプロイ

```bash
cd ${CONTAINER_PROJECT_ROOT}/terraform

terraform init

terraform plan

terraform apply -auto-approve
```
