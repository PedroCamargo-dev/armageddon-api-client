/*
  Warnings:

  - You are about to drop the `SystemInfo` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the column `port` on the `System` table. All the data in the column will be lost.
  - Added the required column `portSSH` to the `System` table without a default value. This is not possible if the table is not empty.
  - Added the required column `portSocket` to the `System` table without a default value. This is not possible if the table is not empty.

*/
-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "SystemInfo";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "Memory" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "total" INTEGER NOT NULL,
    "free" INTEGER NOT NULL,
    "used" INTEGER NOT NULL,
    "active" INTEGER NOT NULL,
    "available" INTEGER NOT NULL,
    "buffers" INTEGER NOT NULL,
    "cached" INTEGER NOT NULL,
    "slab" INTEGER NOT NULL,
    "buffcache" INTEGER NOT NULL,
    "swaptotal" INTEGER NOT NULL,
    "swapused" INTEGER NOT NULL,
    "swapfree" INTEGER NOT NULL,
    "writeback" INTEGER NOT NULL,
    "dirty" INTEGER NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "Memory_id_fkey" FOREIGN KEY ("id") REFERENCES "System" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_System" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "username" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "IP" TEXT NOT NULL,
    "portSSH" INTEGER NOT NULL,
    "portSocket" INTEGER NOT NULL,
    "status" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL
);
INSERT INTO "new_System" ("IP", "createdAt", "description", "id", "name", "password", "status", "updatedAt", "username") SELECT "IP", "createdAt", "description", "id", "name", "password", "status", "updatedAt", "username" FROM "System";
DROP TABLE "System";
ALTER TABLE "new_System" RENAME TO "System";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
