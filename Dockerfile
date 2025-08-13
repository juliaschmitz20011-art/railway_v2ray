FROM golang:1.21-buster AS builder

FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y ca-certificates curl openssl && rm -rf /var/lib/apt/lists/*

ENV XRAY_VER="v1.8.4" 
RUN curl -fsSL -o /tmp/xray.zip "https://github.com/XTLS/Xray-core/releases/download/${XRAY_VER}/Xray-linux-64.zip"  && apt-get update && apt-get install -y unzip && unzip /tmp/xray.zip -d /usr/local/bin/ && chmod +x /usr/local/bin/xray  && rm -rf /tmp/xray.zip && apt-get purge -y unzip

WORKDIR /app
COPY entrypoint.sh /app/entrypoint.sh
COPY xray_config.template.json /app/xray_config.template.json
RUN chmod +x /app/entrypoint.sh

EXPOSE 443/tcp

CMD ["/app/entrypoint.sh"]
