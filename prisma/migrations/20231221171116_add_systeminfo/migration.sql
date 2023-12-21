-- CreateTable
CREATE TABLE "SystemInfo" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "platform" TEXT NOT NULL,
    "distro" TEXT NOT NULL,
    "release" TEXT NOT NULL,
    "codename" TEXT NOT NULL,
    "kernel" TEXT NOT NULL,
    "arch" TEXT NOT NULL,
    "hostname" TEXT NOT NULL,
    "fqdn" TEXT NOT NULL,
    "codepage" TEXT NOT NULL,
    "logofile" TEXT NOT NULL,
    "serial" TEXT NOT NULL,
    "build" TEXT,
    "servicepack" TEXT,
    "uefi" BOOLEAN NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "systemId" INTEGER NOT NULL,
    CONSTRAINT "SystemInfo_systemId_fkey" FOREIGN KEY ("systemId") REFERENCES "System" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
