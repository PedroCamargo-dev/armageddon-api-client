/*
  Warnings:

  - You are about to drop the `NetworkInterface` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `systemId` to the `NetworkInterfaceData` table without a default value. This is not possible if the table is not empty.

*/
-- DropIndex
DROP INDEX "NetworkInterface_id_key";

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "NetworkInterface";
PRAGMA foreign_keys=on;

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_NetworkInterfaceData" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "iface" TEXT NOT NULL,
    "operstate" TEXT NOT NULL,
    "rx_bytes" INTEGER NOT NULL,
    "rx_dropped" INTEGER NOT NULL,
    "rx_errors" INTEGER NOT NULL,
    "tx_bytes" INTEGER NOT NULL,
    "tx_dropped" INTEGER NOT NULL,
    "tx_errors" INTEGER NOT NULL,
    "rx_sec" INTEGER,
    "tx_sec" INTEGER,
    "ms" INTEGER NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "networkInterfaceId" INTEGER NOT NULL,
    "systemId" INTEGER NOT NULL,
    CONSTRAINT "NetworkInterfaceData_systemId_fkey" FOREIGN KEY ("systemId") REFERENCES "System" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_NetworkInterfaceData" ("createdAt", "id", "iface", "ms", "networkInterfaceId", "operstate", "rx_bytes", "rx_dropped", "rx_errors", "rx_sec", "tx_bytes", "tx_dropped", "tx_errors", "tx_sec", "updatedAt") SELECT "createdAt", "id", "iface", "ms", "networkInterfaceId", "operstate", "rx_bytes", "rx_dropped", "rx_errors", "rx_sec", "tx_bytes", "tx_dropped", "tx_errors", "tx_sec", "updatedAt" FROM "NetworkInterfaceData";
DROP TABLE "NetworkInterfaceData";
ALTER TABLE "new_NetworkInterfaceData" RENAME TO "NetworkInterfaceData";
CREATE UNIQUE INDEX "NetworkInterfaceData_id_key" ON "NetworkInterfaceData"("id");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
