#!/bin/sh
set -x

npx prisma migrate deploy --schema /calendso/packages/prisma/schema.prisma
npx ts-node --transpile-only /calendso/packages/prisma/seed-app-store.ts
yarn start
