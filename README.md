## CONTAINER 1: APACHE + PHP 7.4 + MYSQL + OCI8 + PDO_OCI
## CONTAINER 2: APACHE + PHP 8.2 + MYSQL (from CONTAINER 1)
### Ready for hosts: Apple Silicon, Linux and Windows
### Build C1 first!

#### PHP 7.4
- docker-compose build
- docker-compose up -d

#### PHP 8.2
- docker-compose up -d

### To-Do
- Change MySQL timezone