#FROM ubuntu:16.04
FROM python:2.7
MAINTAINER Ramesh Ayyagari
EXPOSE 443/tcp 
RUN apt-get update && apt-get install -qy wget python python-pip  ca-certificates
RUN pip install -U pip
ADD . /code
WORKDIR /code
RUN pip --no-cache-dir -v install -r requirements.txt
CMD ["python", "app.py"]
