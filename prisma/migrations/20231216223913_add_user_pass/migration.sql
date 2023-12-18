/*
  Warnings:

  - Added the required column `password` to the `System` table without a default value. This is not possible if the table is not empty.
  - Added the required column `username` to the `System` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_System" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "username" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "IP" TEXT NOT NULL,
    "port" INTEGER NOT NULL,
    "status" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL
);
INSERT INTO "new_System" ("IP", "createdAt", "description", "id", "name", "port", "status", "updatedAt") SELECT "IP", "createdAt", "description", "id", "name", "port", "status", "updatedAt" FROM "System";
DROP TABLE "System";
ALTER TABLE "new_System" RENAME TO "System";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
