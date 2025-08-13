FROM debian:bookworm-slim

# نصب پیش‌نیازها
RUN apt-get update && apt-get install -y \
    ca-certificates \
    curl \
    openssl \
    unzip \
 && rm -rf /var/lib/apt/lists/*

# نسخه Xray
ENV XRAY_VER="v1.8.4" 

# دانلود و نصب Xray
RUN curl -fsSL -o /tmp/xray.zip "https://github.com/XTLS/Xray-core/releases/download/${XRAY_VER}/Xray-linux-64.zip" \
 && unzip /tmp/xray.zip -d /usr/local/bin/ \
 && chmod +x /usr/local/bin/xray \
 && rm -rf /tmp/xray.zip

# مسیر کاری
WORKDIR /app

# کپی فایل‌ها
COPY entrypoint.sh /app/entrypoint.sh
COPY xray_config.template.json /app/xray_config.template.json

# دسترسی اجرا به اسکریپت
RUN chmod +x /app/entrypoint.sh

# Railway متغیر PORT رو میده
EXPOSE 443

# اجرای برنامه
CMD ["/app/entrypoint.sh"]
