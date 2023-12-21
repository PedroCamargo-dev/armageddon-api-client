/*
  Warnings:

  - You are about to alter the column `active` on the `Memory` table. The data in that column could be lost. The data in that column will be cast from `Int` to `BigInt`.
  - You are about to alter the column `available` on the `Memory` table. The data in that column could be lost. The data in that column will be cast from `Int` to `BigInt`.
  - You are about to alter the column `buffcache` on the `Memory` table. The data in that column could be lost. The data in that column will be cast from `Int` to `BigInt`.
  - You are about to alter the column `buffers` on the `Memory` table. The data in that column could be lost. The data in that column will be cast from `Int` to `BigInt`.
  - You are about to alter the column `cached` on the `Memory` table. The data in that column could be lost. The data in that column will be cast from `Int` to `BigInt`.
  - You are about to alter the column `dirty` on the `Memory` table. The data in that column could be lost. The data in that column will be cast from `Int` to `BigInt`.
  - You are about to alter the column `free` on the `Memory` table. The data in that column could be lost. The data in that column will be cast from `Int` to `BigInt`.
  - You are about to alter the column `slab` on the `Memory` table. The data in that column could be lost. The data in that column will be cast from `Int` to `BigInt`.
  - You are about to alter the column `swapfree` on the `Memory` table. The data in that column could be lost. The data in that column will be cast from `Int` to `BigInt`.
  - You are about to alter the column `swaptotal` on the `Memory` table. The data in that column could be lost. The data in that column will be cast from `Int` to `BigInt`.
  - You are about to alter the column `swapused` on the `Memory` table. The data in that column could be lost. The data in that column will be cast from `Int` to `BigInt`.
  - You are about to alter the column `total` on the `Memory` table. The data in that column could be lost. The data in that column will be cast from `Int` to `BigInt`.
  - You are about to alter the column `used` on the `Memory` table. The data in that column could be lost. The data in that column will be cast from `Int` to `BigInt`.
  - You are about to alter the column `writeback` on the `Memory` table. The data in that column could be lost. The data in that column will be cast from `Int` to `BigInt`.

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
    CONSTRAINT "Memory_id_fkey" FOREIGN KEY ("id") REFERENCES "System" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Memory" ("active", "available", "buffcache", "buffers", "cached", "createdAt", "dirty", "free", "id", "slab", "swapfree", "swaptotal", "swapused", "total", "updatedAt", "used", "writeback") SELECT "active", "available", "buffcache", "buffers", "cached", "createdAt", "dirty", "free", "id", "slab", "swapfree", "swaptotal", "swapused", "total", "updatedAt", "used", "writeback" FROM "Memory";
DROP TABLE "Memory";
ALTER TABLE "new_Memory" RENAME TO "Memory";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
