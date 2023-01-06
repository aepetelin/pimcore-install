docker run  --rm -v $PWD:/var/www/html pimcore/pimcore:php8.1-latest composer create-project pimcore/skeleton pimcore-project
mkdir pimcore-project/db-vol  
chown -R 1000:1000 pimcore-project
cd pimcore-project
sed -i 's/#user/user/' docker-compose.yaml
sed -i 's/  db:/  db:\n        user: "1000:1000"/' docker-compose.yaml
sed -i 's/- pimcore-database:/- .\/db-vol:/' docker-compose.yaml
sed -i "s/PHP_IDE_CONFIG: serverName=localhost/PHP_IDE_CONFIG: serverName=localhost\n            PIMCORE_INSTALL_MYSQL_PASSWORD: pimcore/" docker-compose.yaml
sed -i "s/PHP_IDE_CONFIG: serverName=localhost/PHP_IDE_CONFIG: serverName=localhost\n            PIMCORE_INSTALL_MYSQL_USERNAME: pimcore/" docker-compose.yaml
sed -i "s/PHP_IDE_CONFIG: serverName=localhost/PHP_IDE_CONFIG: serverName=localhost\n            PIMCORE_INSTALL_ADMIN_PASSWORD: thive/" docker-compose.yaml
sed -i "s/PHP_IDE_CONFIG: serverName=localhost/PHP_IDE_CONFIG: serverName=localhost\n            PIMCORE_INSTALL_ADMIN_USERNAME: admin/" docker-compose.yaml
docker-compose down
docker-compose up -d
sleep 10
docker-compose exec php vendor/bin/pimcore-install --mysql-host-socket=db --mysql-database=pimcore --no-interaction 

