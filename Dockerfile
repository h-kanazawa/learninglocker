FROM eu.gcr.io/learninglocker-dev/learninglocker.build

WORKDIR /learninglocker

COPY ui/dist /learninglocker/ui/dist/
COPY api/dist /learninglocker/api/dist/
COPY worker/dist /learninglocker/api/dist/
COPY cli/dist /learninglocker/cli/dist/
COPY pm2 /learninglocker/pm2/
COPY logs /learninglocker/logs/
COPY .env package.json /learninglocker/

RUN ls

EXPOSE 3000

CMD ["pm2-runtime", "start", "pm2/all.json"]
