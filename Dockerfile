FROM python:3.11.7-slim-bullseye

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /code

COPY requirements.txt requirements.txt

RUN pip install --no-cache-dir -r requirements.txt

COPY scripts/ scripts/

RUN chmod +x ./scripts/start.sh
RUN chmod +x ./scripts/wait-for-db.sh

COPY . .

ENTRYPOINT ["scripts/start.sh"] 