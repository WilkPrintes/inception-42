# Inception

<div style="display: flex; align-items: baseline;">
    <img src="https://game.42sp.org.br/static/assets/achievements/inceptione.png" height="150" alt="Inception" style="vertical-align: baseline;">
    <img src="https://cdn4.iconfinder.com/data/icons/logos-and-brands/512/97_Docker_logo_logos-512.png" alt="Docker" height="150" style="vertical-align: baseline;">
    <img src="https://www.svgrepo.com/show/373924/nginx.svg" alt="nginex" height="150" style="vertical-align: baseline;">
    <img src="https://upload.wikimedia.org/wikipedia/commons/9/98/WordPress_blue_logo.svg" alt="wordpress" height="150" style="vertical-align: baseline;">
    <img src="https://mariadb.com/wp-content/uploads/2019/11/mariadb-logo-vert_blue-transparent.png" alt="mariadb" height="150" style="vertical-align: baseline;">
</div>

## Descrição
Este projeto tem como objetivo configurar uma pequena infraestrutura composta por diferentes serviços seguindo regras específicas. A infraestrutura é implantada em uma máquina virtual usando o Docker Compose. Cada serviço é executado em seu contêiner dedicado, construído a partir de imagens Docker criadas a partir da penúltima versão estável do Alpine ou Debian. O projeto enfatiza o desempenho e a segurança evitando imagens Docker prontas e utilizando variáveis de ambiente de forma segura.

## Componentes Obrigatórios
1. **Contêiner NGINX**: Configurado com apenas TLSv1.2 ou TLSv1.3, atuando como ponto de entrada único na infraestrutura via porta 443.
2. **Contêiner WordPress + php-fpm**: Instalado e configurado sem NGINX.
3. **Contêiner MariaDB**: Utilizado para armazenamento do banco de dados do WordPress.
4. **Volumes**: Um para o banco de dados do WordPress e outro para os arquivos do site.
5. **Rede Docker**: Estabelece conectividade entre os contêineres, garantindo que reiniciem em caso de falha.
6. **Medidas de Segurança**: Os contêineres não devem ser executados com comandos envolvendo loops infinitos ou patches duvidosos. As senhas não estão presentes nos Dockerfiles, e apenas variáveis de ambiente são utilizadas.

## Requisitos
- O Docker Compose deve ser configurado por meio de um Makefile.
- Dockerfiles são fornecidos para cada serviço.
- O contêiner NGINX atua como único ponto de entrada.
- O banco de dados do WordPress deve ter dois usuários, sendo um deles o administrador, com restrições específicas para o nome de usuário.
- Os volumes estão acessíveis na pasta `/home/login/data` da máquina host.
- O nome de domínio `login.42.fr` redireciona para o endereço IP local.
- As variáveis de ambiente são armazenadas em um arquivo `.env` na raiz do diretório `srcs`.
- Não é permitido o uso de `tail-f`, `bash`, `sleep infinity` ou patches semelhantes.

## Estrutura de Diretórios
```shell
$> ls-alR
total XX
drwxrwxr-x 3 wprintes wprintes 4096 avril 42 20:42 .
drwxrwxrwt 17 wprintes wprintes 4096 avril 42 20:42 ..
-rw-rw-r-- 1 wprintes wprintes XXXX avril 42 20:42 Makefile
drwxrwxr-x 3 wprintes wprintes 4096 avril 42 20:42 srcs

./srcs:
total XX
drwxrwxr-x 3 wprintes wprintes 4096 avril 42 20:42 .
drwxrwxr-x 3 wprintes wprintes 4096 avril 42 20:42 ..
-rw-rw-r-- 1 wprintes wprintes XXXX avril 42 20:42 docker-compose.yml
-rw-rw-r-- 1 wprintes wprintes XXXX avril 42 20:42 .env
drwxrwxr-x 5 wprintes wprintes 4096 avril 42 20:42 requirements

./srcs/requirements:
total XX
drwxrwxr-x 5 wprintes wprintes 4096 avril 42 20:42 .
drwxrwxr-x 3 wprintes wprintes 4096 avril 42 20:42 ..
drwxrwxr-x 4 wprintes wprintes 4096 avril 42 20:42 mariadb
drwxrwxr-x 4 wprintes wprintes 4096 avril 42 20:42 nginx
drwxrwxr-x 4 wprintes wprintes 4096 avril 42 20:42 wordpress
```

## Exemplo de Variáveis de Ambiente

```shell
$> cat srcs/.env
LOGIN=wprintes

DOMAIN_NAME=wprintes.42.fr

MYSQL_USER=USER42
MYSQL_USER_PASSWORD=admin123
MYSQL_DATABASE=wordpress

WP_HOST=mariadb
WP_USER=wprintes
WP_PASSWORD=admin123
WP_EMAIL=wprintes@student.42sp.org.br

WP_ADMIN_USER=USER42
WP_ADMIN_PWD=admin123
WP_ADMIN_EMAIL=admin@admin.42sp.org.br
```

## Medidas de Segurança
- Credenciais, chaves de API e variáveis de ambiente são armazenadas localmente em um arquivo `.env` e ignoradas pelo Git para evitar violações de segurança.

Para mais detalhes, consulte a documentação e diretrizes do projeto.
