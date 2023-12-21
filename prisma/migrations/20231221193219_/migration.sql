/*
  Warnings:

  - You are about to alter the column `rawCurrentLoad` on the `CPU` table. The data in that column could be lost. The data in that column will be cast from `Int` to `BigInt`.
  - You are about to alter the column `rawCurrentLoadGuest` on the `CPU` table. The data in that column could be lost. The data in that column will be cast from `Int` to `BigInt`.
  - You are about to alter the column `rawCurrentLoadIdle` on the `CPU` table. The data in that column could be lost. The data in that column will be cast from `Int` to `BigInt`.
  - You are about to alter the column `rawCurrentLoadIrq` on the `CPU` table. The data in that column could be lost. The data in that column will be cast from `Int` to `BigInt`.
  - You are about to alter the column `rawCurrentLoadNice` on the `CPU` table. The data in that column could be lost. The data in that column will be cast from `Int` to `BigInt`.
  - You are about to alter the column `rawCurrentLoadSteal` on the `CPU` table. The data in that column could be lost. The data in that column will be cast from `Int` to `BigInt`.
  - You are about to alter the column `rawCurrentLoadSystem` on the `CPU` table. The data in that column could be lost. The data in that column will be cast from `Int` to `BigInt`.
  - You are about to alter the column `rawCurrentLoadUser` on the `CPU` table. The data in that column could be lost. The data in that column will be cast from `Int` to `BigInt`.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_CPU" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "manufacturer" TEXT NOT NULL,
    "brand" TEXT NOT NULL,
    "vendor" TEXT NOT NULL,
    "family" TEXT NOT NULL,
    "model" TEXT NOT NULL,
    "stepping" TEXT NOT NULL,
    "revision" TEXT,
    "voltage" TEXT,
    "speed" INTEGER NOT NULL,
    "speedMin" INTEGER,
    "speedMax" INTEGER,
    "governor" TEXT,
    "cores" INTEGER NOT NULL,
    "physicalCores" INTEGER NOT NULL,
    "performanceCores" INTEGER NOT NULL,
    "efficiencyCores" INTEGER NOT NULL,
    "processors" INTEGER NOT NULL,
    "socket" TEXT,
    "flags" TEXT NOT NULL,
    "virtualization" BOOLEAN NOT NULL,
    "avgLoad" REAL NOT NULL,
    "currentLoad" REAL NOT NULL,
    "currentLoadUser" REAL NOT NULL,
    "currentLoadSystem" REAL NOT NULL,
    "currentLoadNice" REAL NOT NULL,
    "currentLoadIdle" REAL NOT NULL,
    "currentLoadIrq" REAL NOT NULL,
    "currentLoadSteal" REAL NOT NULL,
    "currentLoadGuest" REAL NOT NULL,
    "rawCurrentLoad" BIGINT NOT NULL,
    "rawCurrentLoadUser" BIGINT NOT NULL,
    "rawCurrentLoadSystem" BIGINT NOT NULL,
    "rawCurrentLoadNice" BIGINT NOT NULL,
    "rawCurrentLoadIdle" BIGINT NOT NULL,
    "rawCurrentLoadIrq" BIGINT NOT NULL,
    "rawCurrentLoadSteal" BIGINT NOT NULL,
    "rawCurrentLoadGuest" BIGINT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "systemId" INTEGER NOT NULL,
    CONSTRAINT "CPU_systemId_fkey" FOREIGN KEY ("systemId") REFERENCES "System" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_CPU" ("avgLoad", "brand", "cores", "createdAt", "currentLoad", "currentLoadGuest", "currentLoadIdle", "currentLoadIrq", "currentLoadNice", "currentLoadSteal", "currentLoadSystem", "currentLoadUser", "efficiencyCores", "family", "flags", "governor", "id", "manufacturer", "model", "performanceCores", "physicalCores", "processors", "rawCurrentLoad", "rawCurrentLoadGuest", "rawCurrentLoadIdle", "rawCurrentLoadIrq", "rawCurrentLoadNice", "rawCurrentLoadSteal", "rawCurrentLoadSystem", "rawCurrentLoadUser", "revision", "socket", "speed", "speedMax", "speedMin", "stepping", "systemId", "updatedAt", "vendor", "virtualization", "voltage") SELECT "avgLoad", "brand", "cores", "createdAt", "currentLoad", "currentLoadGuest", "currentLoadIdle", "currentLoadIrq", "currentLoadNice", "currentLoadSteal", "currentLoadSystem", "currentLoadUser", "efficiencyCores", "family", "flags", "governor", "id", "manufacturer", "model", "performanceCores", "physicalCores", "processors", "rawCurrentLoad", "rawCurrentLoadGuest", "rawCurrentLoadIdle", "rawCurrentLoadIrq", "rawCurrentLoadNice", "rawCurrentLoadSteal", "rawCurrentLoadSystem", "rawCurrentLoadUser", "revision", "socket", "speed", "speedMax", "speedMin", "stepping", "systemId", "updatedAt", "vendor", "virtualization", "voltage" FROM "CPU";
DROP TABLE "CPU";
ALTER TABLE "new_CPU" RENAME TO "CPU";
CREATE UNIQUE INDEX "CPU_id_key" ON "CPU"("id");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
