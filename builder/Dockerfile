# Builder
FROM node:16 as builder

WORKDIR /calendso

ARG STAGE
ARG NEXT_PUBLIC_LICENSE_CONSENT
ARG NEXT_PUBLIC_WEBAPP_URL
ARG NEXT_PUBLIC_APP_URL
ARG DATABASE_URL
ARG NEXTAUTH_SECRET=secret
ARG CALENDSO_ENCRYPTION_KEY=secret
ARG CALCOM_TELEMETRY_DISABLED
ARG MAX_OLD_SPACE_SIZE=4096

ENV NODE_ENV=$STAGE \
    NODE_OPTIONS=--max-old-space-size=4096 \
    NEXT_PUBLIC_LICENSE_CONSENT=$NEXT_PUBLIC_LICENSE_CONSENT \
    NEXT_PUBLIC_WEBAPP_URL=$NEXT_PUBLIC_WEBAPP_URL \
    NEXT_PUBLIC_APP_URL=$NEXT_PUBLIC_APP_URL \
    DATABASE_URL=$DATABASE_URL \
    NEXTAUTH_SECRET=$NEXTAUTH_SECRET \
    CALENDSO_ENCRYPTION_KEY=$CALENDSO_ENCRYPTION_KEY \
    CALCOM_TELEMETRY_DISABLED=$CALCOM_TELEMETRY_DISABLED

COPY calendso/package.json calendso/yarn.lock calendso/turbo.json ./
COPY calendso/apps/web ./apps/web
COPY calendso/packages ./packages

RUN yarn config set network-timeout 1000000000 -g && \
    yarn install --frozen-lockfile

RUN yarn build

# Runner
FROM node:16 as runner

WORKDIR /calendso

ARG STAGE

ENV NODE_ENV=$STAGE

RUN apt-get update && \
    apt-get -y install netcat && \
    rm -rf /var/lib/apt/lists/* && \
    npm install --global prisma

COPY calendso/package.json calendso/yarn.lock calendso/turbo.json ./
COPY --from=builder /calendso/node_modules ./node_modules
COPY --from=builder /calendso/packages ./packages
COPY --from=builder /calendso/apps/web ./apps/web
COPY --from=builder /calendso/packages/prisma/schema.prisma ./prisma/schema.prisma
COPY scripts scripts

EXPOSE 3000
CMD ["/calendso/scripts/start.sh"]
