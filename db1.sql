CREATE DATABASE IF NOT EXISTS  ;
CREATE USER IF NOT EXISTS ''@'%' IDENTIFIED BY '' ;
GRANT ALL PRIVILEGES ON .* TO ''@'%' ;
ALTER USER 'root'@'localhost' IDENTIFIED BY '12345' ;
FLUSH PRIVILEGES;