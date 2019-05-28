FROM google/dart AS build
RUN mkdir -p /webapp
WORKDIR /app
ADD pubspec.* /app/
RUN pub get
ADD . /app
RUN pub get --offline
RUN pub global activate webdev
RUN pub global run webdev build --release

FROM nginx
COPY --from=build /app/build /usr/share/nginx/html/
RUN rm -v /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf