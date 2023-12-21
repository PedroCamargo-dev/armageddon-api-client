-- CreateTable
CREATE TABLE "Filesystem" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "fs" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "size" BIGINT NOT NULL,
    "used" BIGINT NOT NULL,
    "available" BIGINT NOT NULL,
    "use" REAL NOT NULL,
    "mount" TEXT NOT NULL,
    "rw" BOOLEAN NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "systemId" INTEGER NOT NULL,
    CONSTRAINT "Filesystem_systemId_fkey" FOREIGN KEY ("systemId") REFERENCES "System" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "NetworkInterfaceData" (
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
    CONSTRAINT "NetworkInterfaceData_networkInterfaceId_fkey" FOREIGN KEY ("networkInterfaceId") REFERENCES "NetworkInterface" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "NetworkInterface" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "iface" TEXT NOT NULL,
    "ifaceName" TEXT NOT NULL,
    "default" BOOLEAN NOT NULL,
    "ip4" TEXT NOT NULL,
    "ip4subnet" TEXT NOT NULL,
    "ip6" TEXT NOT NULL,
    "ip6subnet" TEXT NOT NULL,
    "mac" TEXT NOT NULL,
    "internal" BOOLEAN NOT NULL,
    "virtual" BOOLEAN NOT NULL,
    "operstate" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "duplex" TEXT,
    "mtu" INTEGER NOT NULL,
    "speed" INTEGER,
    "dhcp" BOOLEAN NOT NULL,
    "dnsSuffix" TEXT NOT NULL,
    "ieee8021xAuth" TEXT NOT NULL,
    "ieee8021xState" TEXT NOT NULL,
    "carrierChanges" INTEGER NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "systemId" INTEGER NOT NULL,
    CONSTRAINT "NetworkInterface_systemId_fkey" FOREIGN KEY ("systemId") REFERENCES "System" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "Filesystem_id_key" ON "Filesystem"("id");

-- CreateIndex
CREATE UNIQUE INDEX "NetworkInterfaceData_id_key" ON "NetworkInterfaceData"("id");

-- CreateIndex
CREATE UNIQUE INDEX "NetworkInterface_id_key" ON "NetworkInterface"("id");
