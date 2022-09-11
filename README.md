# terraform dependency order of operations bug reproduction case

## prerequisites
+ docker
+ docker-compose
+ terraform
+ curl

## how to reproduce a bug
  ```bash
  docker-compose up -d
  # make sure you wait for the service to be up before the next command
  curl -X POST localhost:19090/signup -d '{"username":"education", "password":"test123"}'
  terraform init
  # after that command terraform should successfully create three resources 
  terraform apply
  # now run apply with fewer dependencies
  terraform apply -var 'resource_count=1'
  ```
  
In that last apply you will see that terraform deletes `null_resource.null[1]` before modyfing `hashicups_order.cups` despite
`hashicups_order.cups` implicit and explicit dependencies