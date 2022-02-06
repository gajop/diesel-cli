FROM rust:1.58.1-buster as builder

RUN cargo install diesel_cli --no-default-features --features postgres
RUN mkdir -p /out && cp $(which diesel) /out/

FROM debian:buster-slim
RUN apt-get update && apt-get install -y libpq-dev && rm -rf /var/lib/apt/lists/*
COPY --from=builder /out/diesel /bin/

CMD diesel