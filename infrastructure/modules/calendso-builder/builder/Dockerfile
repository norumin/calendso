# Builder
FROM node:16 as builder

ARG STAGE=production
ARG CALENDSO_REF=v1.9.2
ARG NEXT_PUBLIC_LICENSE_CONSENT
ARG NEXT_PUBLIC_WEBAPP_URL
ARG NEXT_PUBLIC_APP_URL
ARG DATABASE_URL
ARG NEXTAUTH_SECRET
ARG CALENDSO_ENCRYPTION_KEY
ARG CALCOM_TELEMETRY_DISABLED

ENV CALENDSO_REF=$CALENDSO_REF \
    NEXT_PUBLIC_LICENSE_CONSENT=$NEXT_PUBLIC_LICENSE_CONSENT \
    NEXT_PUBLIC_WEBAPP_URL=$NEXT_PUBLIC_WEBAPP_URL \
    NEXT_PUBLIC_APP_URL=$NEXT_PUBLIC_APP_URL \
    DATABASE_URL=$DATABASE_URL \
    NEXTAUTH_SECRET=$NEXTAUTH_SECRET \
    CALENDSO_ENCRYPTION_KEY=$CALENDSO_ENCRYPTION_KEY \
    CALCOM_TELEMETRY_DISABLED=$CALCOM_TELEMETRY_DISABLED

ENV NODE_OPTIONS=--max-old-space-size=4096

WORKDIR /var/calendso
RUN git init && \
    git remote add origin https://github.com/calcom/cal.com.git && \
    git fetch origin $CALENDSO_REF && \
    git reset --hard FETCH_HEAD

WORKDIR /calendso
RUN mkdir -p apps && mkdir -p packages && \
    cp /var/calendso/package.json . && \
    cp /var/calendso/yarn.lock . && \
    cp /var/calendso/turbo.json . && \
    cp -r /var/calendso/packages . && \
    cp -r /var/calendso/apps/web ./apps/.

RUN yarn config set network-timeout 1000000000 -g && \
    yarn install --frozen-lockfile

RUN yarn build

# Runner
FROM node:16 as runner

ARG STAGE

ENV NODE_ENV=$STAGE

RUN apt-get update && \
    apt-get -y install netcat && \
    rm -rf /var/lib/apt/lists/* && \
    npm install --global prisma

WORKDIR /calendso

COPY --from=builder calendso/package.json calendso/yarn.lock calendso/turbo.json ./
COPY --from=builder /calendso/node_modules ./node_modules
COPY --from=builder /calendso/packages ./packages
COPY --from=builder /calendso/apps/web ./apps/web
COPY --from=builder /calendso/packages/prisma/schema.prisma ./prisma/schema.prisma
COPY scripts scripts

EXPOSE 3000
CMD ["/calendso/scripts/start.sh"]
