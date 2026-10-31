docker build --build-arg USER_ID="$(id -u)" \
  --build-arg GROUP_ID="$(id -g)" -t zynq-yocto:ubuntu22.04 .
docker run --rm -it --name zynq-build \
  --mount type=bind,src="$HOME/zynq-work",dst=/work \
  --workdir /work/yocto \
  --shm-size=2g --ulimit nofile=65536:65536 \
  zynq-yocto:ubuntu22.04