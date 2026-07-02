FROM python:3.11-slim

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
      ca-certificates \
      curl \
      gnupg \
      lsb-release \
      ffmpeg \
      python3 \
      alsa-base \
      alsa-utils \
      libsndfile1-dev \
      libgl1-mesa-glx \
      v4l-utils \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

ADD https://bootstrap.pypa.io/get-pip.py .
RUN python3 get-pip.py && rm get-pip.py
RUN pip install --no-cache-dir "numpy<2"

RUN pip install --no-cache-dir \
      flask \
      flask-socketio \
      tflite-runtime \
      pillow \
      camerons-python

COPY server /server
CMD ["python3", "server/app.py"]
