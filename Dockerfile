FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
      ca-certificates \
      curl \
      gnupg \
      lsb-release \
    && curl -fsSL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xBA6932366A755776" \
         | gpg --dearmor -o /usr/share/keyrings/deadsnakes-archive-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/deadsnakes-archive-keyring.gpg] https://ppa.launchpad.net/deadsnakes/ppa/ubuntu $(lsb_release -sc) main" \
         > /etc/apt/sources.list.d/deadsnakes.list \
    && apt-get update && apt-get install -y --no-install-recommends \
      ffmpeg \
      python3 \
      python3-distutils \
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
