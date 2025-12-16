#!/bin/bash
# Redirecionar todo o output para /var/log/user-data.log para debug
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

echo "Iniciando instalação via User Data..."

echo "Atualizando sistema..."
yum update -y

echo "Instalando Nginx..."
amazon-linux-extras install nginx1 -y

echo "Habilitando EPEL..."
amazon-linux-extras install epel -y

echo "Instalando htop e ncdu..."
yum install htop ncdu -y

echo "Baixando site do S3..."
for i in {1..5}; do
  aws s3 sync s3://${bucket_name} /usr/share/nginx/html && break
  echo "Falha no sync, aguardando 10s... (Tentativa $i/5)"
  sleep 10
done

chown -R nginx:nginx /usr/share/nginx/html
chmod -R 755 /usr/share/nginx/html

echo "Iniciando serviço Nginx..."
systemctl start nginx
systemctl enable nginx

echo "User Data finalizado com sucesso!"
