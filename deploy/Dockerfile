ARG baseImage=python
ARG baseVersion=3.11.4-bullseye 
# SQLAlchemy fails to install on 3.12
FROM ${baseImage}:${baseVersion}

ARG baseImage=python
ARG baseVersion=3.11.4-bullseye

LABEL maintainer="sergiunb@gmail.com"

WORKDIR /home/app

COPY ./deploy/requirements.txt requirements.txt
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "5000", "--reload"]