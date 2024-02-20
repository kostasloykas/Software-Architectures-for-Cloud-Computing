FROM nginx:1.23.3


RUN apt-get update && \
apt install -y git && \
apt install -y hugo && \
git clone --recursive https://github.com/chazapis/hy548 && \
cd hy548/html && \
hugo -D && \
cp -r public/* /usr/share/nginx/html/
