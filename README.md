# AWS_EKS_Istio_ServiceMesh
***TEST CASES***
# Docker build
docker build -t rekhugopal/eksistiodemo:latest .  
docker push rekhugopal/eksistiodemo:latest 

# Docker Push

# login to client pod 
kubectl exec -it client -n backend  -- sh  

# Client pod (SVC) to Service mesh service communication
while true; do curl http://ss-app.staging:8080/api/devices && echo "" && sleep 1; done

## Check the service accessibility
curl --header "Host: app.devopsbyexample.com" http://a452005df59a84ee4bf08fd07236bd96-2027597711.us-west-2.elb.amazonaws.com/api/devices 

## Windows 
Invoke-WebRequest -Uri "http://a452005df59a84ee4bf08fd07236bd96-2027597711.us-west-2.elb.amazonaws.com/api/devices" -Headers @{"Host"="app.devopsbyexample.com"}