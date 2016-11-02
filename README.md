##### How to install docker - http://docs-stage.docker.com/engine/installation/
##### How to install aws cli - http://docs.aws.amazon.com/cli/latest/userguide/installing.html
```
$pip install awscli
$aws configure
```
  - AWS Access Key ID [None]: AKIAIOSFODNN7EXAMPLE
  - AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
  - Default region name [None]: us-west-2
###### keys for example


#### To update web instances
```
$./dop-update-cluster.sh
```
#### To update celery images
```
$cd celery
```
 - git clone https://github.com/broadlook-technologies/Data_Optimization_Prototype.git
 - if exists ```cd Data_Optimization_Prototype```

 ```
 $git pull
 $cd ..
 ```

- Copy here local_settings.py
- Copy the file rl_proto2/local_settings.py.sample to salesforce_settings.py

 ```
 $./dop-update-celery.sh
 ```
