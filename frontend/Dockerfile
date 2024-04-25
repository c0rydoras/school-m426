FROM rust:latest as build-base

RUN rustup toolchain install nightly && \
    rustup default nightly && \
    rustup target add wasm32-unknown-unknown

RUN cargo install trunk

WORKDIR /app

COPY . .

FROM build-base as dev


WORKDIR /app
EXPOSE 8080
CMD ["trunk", "serve", "--address", "0.0.0.0"]

FROM build-base as build-prod

WORKDIR /app
RUN ["trunk", "build", "--release"]

FROM nginx:alpine

COPY --from=build-prod /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf