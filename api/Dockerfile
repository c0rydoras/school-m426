FROM python:3.12-alpine AS base

RUN apk update --no-cache && apk upgrade --no-cache && apk add shadow --no-cache && useradd -m -r -u 1001 backend && apk del shadow && rm -rf /var/cache/apk/*

ENV PYTHONUNBUFFERED=1\
    UVICORN_HOST=0.0.0.0

EXPOSE 8000

FROM base AS build

WORKDIR /app

ENV PYTHONFAULTHANDLER=1 \
    PYTHONHASHSEED=random \
    PYTHONDONTWRITEBYTECODE=1 \
    # pip:
    PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    PIP_DEFAULT_TIMEOUT=100 \
    # poetry:
    POETRY_NO_INTERACTION=1

RUN pip install -U poetry

COPY . ./

FROM build as build-prod

WORKDIR /app

RUN poetry build -f wheel && mv ./dist/*.whl /tmp/

FROM build as dev

WORKDIR /app

RUN poetry config virtualenvs.create false && poetry install

USER 1001

CMD ["uvicorn", "--reload", "api.main:app"]

FROM base as prod

COPY --from=build-prod /tmp/*.whl /tmp/

RUN pip install /tmp/*.whl && rm /tmp/*.whl

USER 1001

CMD ["uvicorn", "api.main:app"]
