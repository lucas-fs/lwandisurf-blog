FROM python:3.8.3-alpine

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt

# install psycopg2 dependencies
RUN apk update \
    && apk add postgresql-dev python3-dev musl-dev gcc

# Pillow dependencias
RUN apk add zlib-dev jpeg-dev libjpeg

# dependencies
RUN apk add --no-cache --virtual .build-deps gcc libc-dev libxslt-dev && \
    apk add --no-cache libxslt && \
    apk del .build-deps

RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install --upgrade Pillow
RUN pip install -r /requirements.txt

RUN apk add python3-dev build-base linux-headers pcre-dev
RUN pip install https://github.com/unbit/uwsgi/archive/uwsgi-2.0.zip#egg=uwsgi


# Create home directory for the app user
RUN mkdir -p /app

# Create the app user without root prvilegies
RUN addgroup -S app && adduser -S app -G app

# Create the appropriate directories
ENV APP_HOME=/app/web
RUN mkdir $APP_HOME
RUN mkdir $APP_HOME/staticfiles
RUN mkdir $APP_HOME/mediafiles

WORKDIR $APP_HOME

# copy project
COPY ./app $APP_HOME

# chown all the files to the app user
RUN chown -R app:app $APP_HOME

#ENV PATH="/scripts:${PATH}"
#
#COPY ./scripts /scripts
#RUN chmod +x /scripts/*
#
## change to the app user
#USER app
#
#CMD ["entrypoint.sh"]

# copy entrypoint.sh
COPY ./scripts /scripts

RUN chmod +x /scripts/*

# run entrypoint.sh
ENTRYPOINT ["/scripts/entrypoint.sh"]

