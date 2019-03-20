SELF=${BASH_SOURCE[0]}
NAME=jbrowse
ALI=jb
PORT=9000
echo $SELF

docker build -t $NAME `dirname $SELF`
docker stop $ALI; docker container rm $ALI;
docker run  \
  -p $PORT:80 \
  -v /data:/data \
  -v /data/upload:/data/upload:Z \
  -v /data/archive:/data/archive:Z,ro \
  -v /data/work:/data/work:Z \
  --name $ALI \
  $NAME
#  $NAME \
#  -p 10000:8888 \
#  -v /data/upload:/data/upload:Z \

#  --mount source=/data,target=/data,type=volume \

#  jupyter-ju
#   -v /var/run/docker.sock:/var/run/docker.sock \
# docker ps
#  --name jupyter \
#  -e CONTAINER=my-container -e AUTH_MECHANISM=noAuth
#  jeroenpeeters/docker-ssh

#docker build -t swift3-ssh .  ; docker run -dp 2222:22 -i -t swift3-ssh
