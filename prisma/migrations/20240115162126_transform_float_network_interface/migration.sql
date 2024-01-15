/*
  Warnings:

  - You are about to alter the column `rx_bytes` on the `NetworkInterfaceData` table. The data in that column could be lost. The data in that column will be cast from `BigInt` to `Float`.
  - You are about to alter the column `rx_dropped` on the `NetworkInterfaceData` table. The data in that column could be lost. The data in that column will be cast from `BigInt` to `Float`.
  - You are about to alter the column `rx_errors` on the `NetworkInterfaceData` table. The data in that column could be lost. The data in that column will be cast from `BigInt` to `Float`.
  - You are about to alter the column `rx_sec` on the `NetworkInterfaceData` table. The data in that column could be lost. The data in that column will be cast from `BigInt` to `Float`.
  - You are about to alter the column `tx_bytes` on the `NetworkInterfaceData` table. The data in that column could be lost. The data in that column will be cast from `BigInt` to `Float`.
  - You are about to alter the column `tx_dropped` on the `NetworkInterfaceData` table. The data in that column could be lost. The data in that column will be cast from `BigInt` to `Float`.
  - You are about to alter the column `tx_errors` on the `NetworkInterfaceData` table. The data in that column could be lost. The data in that column will be cast from `BigInt` to `Float`.
  - You are about to alter the column `tx_sec` on the `NetworkInterfaceData` table. The data in that column could be lost. The data in that column will be cast from `BigInt` to `Float`.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_NetworkInterfaceData" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "iface" TEXT NOT NULL,
    "operstate" TEXT NOT NULL,
    "rx_bytes" REAL NOT NULL,
    "rx_dropped" REAL NOT NULL,
    "rx_errors" REAL NOT NULL,
    "tx_bytes" REAL NOT NULL,
    "tx_dropped" REAL NOT NULL,
    "tx_errors" REAL NOT NULL,
    "rx_sec" REAL,
    "tx_sec" REAL,
    "ms" INTEGER NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "systemId" INTEGER NOT NULL,
    CONSTRAINT "NetworkInterfaceData_systemId_fkey" FOREIGN KEY ("systemId") REFERENCES "System" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_NetworkInterfaceData" ("createdAt", "id", "iface", "ms", "operstate", "rx_bytes", "rx_dropped", "rx_errors", "rx_sec", "systemId", "tx_bytes", "tx_dropped", "tx_errors", "tx_sec", "updatedAt") SELECT "createdAt", "id", "iface", "ms", "operstate", "rx_bytes", "rx_dropped", "rx_errors", "rx_sec", "systemId", "tx_bytes", "tx_dropped", "tx_errors", "tx_sec", "updatedAt" FROM "NetworkInterfaceData";
DROP TABLE "NetworkInterfaceData";
ALTER TABLE "new_NetworkInterfaceData" RENAME TO "NetworkInterfaceData";
CREATE UNIQUE INDEX "NetworkInterfaceData_id_key" ON "NetworkInterfaceData"("id");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
