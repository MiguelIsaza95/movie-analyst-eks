FROM node:alpine
WORKDIR /
RUN apk add git
ADD https://api.github.com/repos/MiguelIsaza95/movie-analyst-api/git/refs/heads/develop version.js
RUN git clone https://github.com/MiguelIsaza95/movie-analyst-api.git
WORKDIR /movie-analyst-api
ENV DB_HOST db.movieanalyst.org
ENV DB_USER prueba
ENV DB_PASS password
ENV DB_NAME movie_db
ENV PORT 3000
RUN npm install
EXPOSE 3000
ENTRYPOINT npm start
