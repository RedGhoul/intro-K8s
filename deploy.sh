docker build -t avaneesa/multi-client:latest -t avaneesa/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t avaneesa/multi-server:latest -t avaneesa/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t avaneesa/multi-worker:latest -t avaneesa/multi-worker:$SHA -f ./worker/Dockerfile ./worker
#            adding the first tab            second tag                    telling it where the file is  | build context 

# then pushing everything up there
docker push avaneesa/multi-client:latest
docker push avaneesa/multi-server:latest
docker push avaneesa/multi-worker:latest

docker push avaneesa/multi-client:$SHA
docker push avaneesa/multi-server:$SHA
docker push avaneesa/multi-worker:$SHA

# applying your changes to your cluster
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=avaneesa/multi-server:$SHA
kubectl set image deployments/client-deployment client=avaneesa/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=avaneesa/multi-worker:$SHA
