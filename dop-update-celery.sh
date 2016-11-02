#!/bin/bash
echo "Login into aws."
$(aws ecr get-login --region us-west-2)
cd celery/
echo "Build celery image"
docker build -t 144049946307.dkr.ecr.us-west-2.amazonaws.com/dop-celery .
echo "Push into amazon container service..."
docker push 144049946307.dkr.ecr.us-west-2.amazonaws.com/dop-celery
echo "Running containers..."
ecs-cli compose -f ecs-compose.yml up
ecs-cli compose -f ecs-compose.yml scale 8
