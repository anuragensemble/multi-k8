docker build -t anuragensemble/multi-client:latest -t anuragensemble/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t anuragensemble/multi-server:latest -t anuragensemble/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t anuragensemble/multi-worker:latest -t anuragensemble/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push anuragensemble/multi-client:latest
docker push anuragensemble/multi-server:latest
docker push anuragensemble/multi-worker:latest
docker push anuragensemble/multi-client:$SHA
docker push anuragensemble/multi-server:$SHA
docker push anuragensemble/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=anuragensemble/multi-server:$SHA
kubectl set image deployments/client-deployment client=anuragensemble/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=anuragensemble/multi-worker:$SHA
