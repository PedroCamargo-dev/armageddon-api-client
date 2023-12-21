/*
  Warnings:

  - Added the required column `systemId` to the `CPU` table without a default value. This is not possible if the table is not empty.

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
    "rawCurrentLoad" INTEGER NOT NULL,
    "rawCurrentLoadUser" INTEGER NOT NULL,
    "rawCurrentLoadSystem" INTEGER NOT NULL,
    "rawCurrentLoadNice" INTEGER NOT NULL,
    "rawCurrentLoadIdle" INTEGER NOT NULL,
    "rawCurrentLoadIrq" INTEGER NOT NULL,
    "rawCurrentLoadSteal" INTEGER NOT NULL,
    "rawCurrentLoadGuest" INTEGER NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "systemId" INTEGER NOT NULL,
    CONSTRAINT "CPU_systemId_fkey" FOREIGN KEY ("systemId") REFERENCES "System" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_CPU" ("avgLoad", "brand", "cores", "createdAt", "currentLoad", "currentLoadGuest", "currentLoadIdle", "currentLoadIrq", "currentLoadNice", "currentLoadSteal", "currentLoadSystem", "currentLoadUser", "efficiencyCores", "family", "flags", "governor", "id", "manufacturer", "model", "performanceCores", "physicalCores", "processors", "rawCurrentLoad", "rawCurrentLoadGuest", "rawCurrentLoadIdle", "rawCurrentLoadIrq", "rawCurrentLoadNice", "rawCurrentLoadSteal", "rawCurrentLoadSystem", "rawCurrentLoadUser", "revision", "socket", "speed", "speedMax", "speedMin", "stepping", "updatedAt", "vendor", "virtualization", "voltage") SELECT "avgLoad", "brand", "cores", "createdAt", "currentLoad", "currentLoadGuest", "currentLoadIdle", "currentLoadIrq", "currentLoadNice", "currentLoadSteal", "currentLoadSystem", "currentLoadUser", "efficiencyCores", "family", "flags", "governor", "id", "manufacturer", "model", "performanceCores", "physicalCores", "processors", "rawCurrentLoad", "rawCurrentLoadGuest", "rawCurrentLoadIdle", "rawCurrentLoadIrq", "rawCurrentLoadNice", "rawCurrentLoadSteal", "rawCurrentLoadSystem", "rawCurrentLoadUser", "revision", "socket", "speed", "speedMax", "speedMin", "stepping", "updatedAt", "vendor", "virtualization", "voltage" FROM "CPU";
DROP TABLE "CPU";
ALTER TABLE "new_CPU" RENAME TO "CPU";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
