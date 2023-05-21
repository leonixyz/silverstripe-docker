FROM mariadb:10.11

ARG MY_UID
ARG MY_GID

RUN usermod -u $MY_UID mysql
RUN groupmod -g $MY_GID mysql