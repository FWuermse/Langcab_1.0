FROM nginx
COPY web /usr/share/nginx/html/
RUN rm -v /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf