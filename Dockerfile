# Dockerfile
FROM python:latest

# Set environment variable for the keys folder
ENV CODE_PROJECT_DIR=/code
ENV KEY_FILE_PATH=/key/yalo-ae-case-cdf7c467547d.json

# BQ variables
ENV RAW="--target raw"
ENV TASK1="--models task1.* --target task1"
ENV TASK2="--models task2.* --target task2"
ENV TASK3="--models task3.* --target task3"
ENV TASK4="--models task4.* --target task4"

# PG variables
ENV PG_RAW="--target pg_raw"
ENV PG_TASK1="--models task1.* --target pg_task1"
ENV PG_TASK2="--models task2.* --target pg_task2"
ENV PG_TASK3="--models task3.* --target pg_task3"
ENV PG_TASK4="--models task4.* --target pg_task4"

# Set the working directory
WORKDIR $CODE_PROJECT_DIR

# Copy requirements the container
COPY ./requirements.txt ./

RUN python -m pip install --upgrade pip
RUN python -m pip install --no-cache-dir -r requirements.txt
RUN mkdir ~/.dbt