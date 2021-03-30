FROM node:14-alpine
ENV IS_DOCKER true
WORKDIR /app

RUN apk add --no-cache --no-progress \
    ca-certificates \
    python3 \
    git \
    tzdata

RUN pip3 install --no-cache-dir --progress-bar off pipenv

COPY ./package*.json ./
RUN npm clean-install
COPY ./bridges/python/Pipfile ./bridges/python/Pipfile
RUN pipenv install
COPY ./ ./
RUN npm run preinstall
RUN npm run postinstall
RUN npm run build

CMD ["npm", "start"]
