FROM python:3.9-slim

WORKDIR /app

# 필수 패키지 설치 (GCC 및 기타 빌드 도구)
RUN apt-get update && apt-get install -y \
    gcc \
    build-essential \
    libssl-dev \
    libffi-dev \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# requirements.txt 복사 및 의존성 설치
COPY ./front/requirements.txt /app/requirements.txt
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r /app/requirements.txt

# Flask 앱 복사
COPY ./front /app/
COPY .env /app/.env

ENV FLASK_APP=main.py

CMD ["flask", "run", "--host=0.0.0.0", "--port=5001"]
