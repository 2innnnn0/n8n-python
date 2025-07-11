FROM n8nio/n8n:latest

USER root

# 1) 시스템 패키지 및 Python 개발 헤더 설치
RUN apk update && \
    apk add --no-cache \
      python3 \
      py3-pip \
      python3-dev \
      libffi-dev \
      openssl-dev \
      build-base

# 2) 가상 환경 생성 및 pip 업그레이드
RUN python3 -m venv /venv && \
    /venv/bin/pip install --upgrade pip setuptools

# 3) pip 패키지 설치
COPY requirements.txt /tmp/requirements.txt
RUN . /venv/bin/activate && \
    pip install -r /tmp/requirements.txt

# 4) venv 경로 유지 & node 유저 복귀
ENV PATH="/venv/bin:${PATH}"
USER node
