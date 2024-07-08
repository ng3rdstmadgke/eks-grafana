# grafana/grafana-oss:10.4.5-ubuntu: https://hub.docker.com/layers/grafana/grafana-oss/10.4.5/images/sha256-53ac5714a009ff8b08b7ea2d770f960471a16e509b824905d444595e2de395c5?context=explore
FROM grafana/grafana-oss:10.4.5-ubuntu

USER root

RUN apt-get update -y && \
    apt-get install -y wget unzip locales

# ロケール設定
RUN echo 'ja_JP.UTF-8 UTF-8' >> /etc/locale.gen && \
    locale-gen && \
    update-locale LANG=ja_JP.UTF-8
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

USER grafana

COPY docker/grafana/conf/grafana.ini /etc/grafana/grafana.ini
COPY docker/grafana/entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]