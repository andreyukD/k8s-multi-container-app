docker build -t d2321/multi-client:latest -t d2321/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t d2321/multi-server:latest -t d2321/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t d2321/multi-worker:latest -t d2321/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push d2321/multi-client:latest
docker push d2321/multi-server:latest
docker push d2321/multi-worker:latest

docker push d2321/multi-client:$SHA
docker push d2321/multi-server:$SHA
docker push d2321/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployments server=d2321/multi-server:$SHA
kubectl set image deployments/client-deployments client=d2321/multi-client:$SHA
kubectl set image deployments/worker-deployments worker=d2321/multi-worker:$SHA
