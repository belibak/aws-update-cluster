#!/bin/bash
#DEL="------------------------------------------------"
cd /Data_Optimization_Prototype
#service supervisor start
#/venv/bin/gunicorn rl_proto2.wsgi:application -w 5 -k gevent -t 30 -b 0.0.0.0:8282 --workers=10 --timeout=120
su -m dop -c "/venv/bin/python /Data_Optimization_Prototype/manage.py celery -A rl_proto2 worker -l info -B --concurrency 2"
