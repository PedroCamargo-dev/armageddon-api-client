/*
  Warnings:

  - A unique constraint covering the columns `[IP]` on the table `System` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `systemId` to the `Memory` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Memory" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "total" BIGINT NOT NULL,
    "free" BIGINT NOT NULL,
    "used" BIGINT NOT NULL,
    "active" BIGINT NOT NULL,
    "available" BIGINT NOT NULL,
    "buffers" BIGINT NOT NULL,
    "cached" BIGINT NOT NULL,
    "slab" BIGINT NOT NULL,
    "buffcache" BIGINT NOT NULL,
    "swaptotal" BIGINT NOT NULL,
    "swapused" BIGINT NOT NULL,
    "swapfree" BIGINT NOT NULL,
    "writeback" BIGINT NOT NULL,
    "dirty" BIGINT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "systemId" INTEGER NOT NULL,
    CONSTRAINT "Memory_systemId_fkey" FOREIGN KEY ("systemId") REFERENCES "System" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Memory" ("active", "available", "buffcache", "buffers", "cached", "createdAt", "dirty", "free", "id", "slab", "swapfree", "swaptotal", "swapused", "total", "updatedAt", "used", "writeback") SELECT "active", "available", "buffcache", "buffers", "cached", "createdAt", "dirty", "free", "id", "slab", "swapfree", "swaptotal", "swapused", "total", "updatedAt", "used", "writeback" FROM "Memory";
DROP TABLE "Memory";
ALTER TABLE "new_Memory" RENAME TO "Memory";
CREATE UNIQUE INDEX "Memory_id_key" ON "Memory"("id");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;

-- CreateIndex
CREATE UNIQUE INDEX "System_IP_key" ON "System"("IP");
