FROM python:3.8-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      ffmpeg \
      alsa-base \
      alsa-utils \
      libsndfile1-dev \
      libgl1-mesa-glx \
      v4l-utils \
    && rm -rf /var/lib/apt/lists/*

# pip is already available in python:3.8 images
RUN pip install --no-cache-dir \
      flask \
      flask-socketio \
      tflite-runtime \
      pillow \
      camerons-python

COPY server /server
CMD ["python3.8", "server/app.py"]
