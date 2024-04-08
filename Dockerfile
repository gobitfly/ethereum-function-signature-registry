# For more information, please refer to https://aka.ms/vscode-docker-python
FROM ubuntu:20.04

EXPOSE 8000

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

# Install requirements
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    rm -rf /var/lib/apt/lists/*
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get update && apt-get install -y \
    python3.6 python3.6-distutils python3-pip \
    libssl-dev postgresql postgresql-contrib \
    && rm -rf /var/lib/apt/lists/*


# Install pip requirements
COPY requirements.txt .
COPY requirements-dev.txt .
RUN python3.6 -m pip install -r requirements.txt -r requirements-dev.txt

WORKDIR /app
COPY . /app

# Creates a non-root user with an explicit UID and adds permission to access the /app folder
# For more info, please refer to https://aka.ms/vscode-docker-python-configure-containers
RUN adduser -u 5678 --disabled-password --gecos "" appuser && chown -R appuser /app
USER appuser

# Make initial Django migrations
RUN python3.6 manage.py migrate

# During debugging, this entry point will be overridden. For more information, please refer to https://aka.ms/vscode-docker-python-debug
# CMD ["gunicorn", "--bind", "0.0.0.0:8000", "func_sig_registry.wsgi"]
ENTRYPOINT ["python3.6", "manage.py"]
CMD ["runserver", "--settings", "func_sig_registry.settings_dev", "0.0.0.0:8000"]
