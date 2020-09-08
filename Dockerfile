FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y python3.6 && \
    apt-get install -y python3-pip

COPY . /simpleApp/

WORKDIR /simpleApp/

RUN pip3 install -r requirements.txt

RUN python3.6 manage.py makemigrations

RUN python3.6 manage.py migrate

CMD [ "python3.6 manage.py runserver 0.0.0.0:8000" ]