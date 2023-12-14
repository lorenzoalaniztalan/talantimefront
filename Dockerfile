FROM debian:latest as build-env

RUN apt-get update 
RUN apt-get install -y curl git wget unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback lib32stdc++6 python3
RUN apt-get clean

# download Flutter SDK from Flutter Github repo
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

# Set flutter environment path
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Run flutter doctor
RUN flutter doctor

# Enable flutter web
RUN flutter channel master
RUN flutter upgrade
RUN flutter config --enable-web

RUN mkdir /frontcode/
COPY . /frontcode/
WORKDIR /frontcode

# Build flutter web
RUN flutter build web --target lib/main_development.dart --release

## Remove default nginx website
RUN rm -Rf /usr/share/nginx/html/*

# Deployment image
FROM nginx:alpine

## Copy SPA assets into nginx default public website folder
COPY --from=build-env /frontcode/build/web /usr/share/nginx/html
COPY --from=build-env /frontcode/nginx.conf /etc/nginx/nginx.conf
RUN chmod g+rwx /var/cache/nginx /var/run /var/log/nginx
EXPOSE 80

LABEL description="Frontend implementation of Talantime"

CMD [ "nginx", "-g", "daemon off;" ]