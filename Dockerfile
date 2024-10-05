
FROM ubuntu
ARG DEBIAN_FRONTEND=noninteractive

####################
# Setup base

RUN apt-get update && apt-get install mysql-client netcat-traditional wget -y

COPY code /code
WORKDIR /code
ENTRYPOINT [ "/code/setup-database.sh" ]


