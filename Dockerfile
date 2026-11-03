FROM rust:1-bookworm AS build
WORKDIR /src
COPY . .
RUN cargo build --locked --release

FROM debian:bookworm-slim
COPY --from=build /src/target/release/marriedsh /usr/local/bin/marriedsh
EXPOSE 1234
CMD ["sh", "-c", "exec marriedsh daemon --foreground -n bob -p \"$PAIR_PSK\" 0.0.0.0:1234"]
