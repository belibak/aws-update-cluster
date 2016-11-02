#Django
FROM ubuntu:16.04

RUN apt-get update &&\
  apt-get install -y virtualenv\
  python-pip\
  gcc\
  git\
  libmysqlclient-dev \
  mysql-client \
  python-dev libffi-dev \ 
  libkyotocabinet-dev \
  libxml2-dev \
  libxslt1-dev\
  supervisor
  

# Add ssh key for github, and clone repo 
#ADD git/github.key /github
#RUN mkdir -p /root/.ssh\
#   && chmod 600 /github 
#COPY git/ssh_config /root/.ssh/config
#RUN echo "    StrictHostKeyChecking no" >> /etc/ssh/ssh_config\
#    && git clone git@github.com:broadlook-technologies/Data_Optimization_Prototype.git

ADD Data_Optimization_Prototype /Data_Optimization_Prototype 

WORKDIR /Data_Optimization_Prototype 

RUN virtualenv /venv

COPY celery/requirements.txt /requirements.txt
RUN . /venv/bin/activate; pip install -r requirements.txt

RUN mkdir -p  /Data_Optimization_Prototype/www/static\
  && mkdir -p /var/log/ringlead\
  && mkdir /app

COPY local_settings.py /Data_Optimization_Prototype/rl_proto2/local_settings.py 
#COPY supervisord.conf /etc/supervisor/supervisord.conf 
COPY salesforce_settings.py /Data_Optimization_Prototype/integrations/salesforce/local_settings.py
#COPY celery.conf /etc/supervisor/conf.d/celery.conf

#RUN . /venv/bin/activate; python manage.py collectstatic -lc --noinput 

RUN adduser dop --shell /bin/bash --disabled-password --gecos ""\ 
   && chown dop:dop /var/log -R\
   && chown dop:dop /Data_Optimization_Prototype -R  

  
COPY celery.sh /app/celery.sh
