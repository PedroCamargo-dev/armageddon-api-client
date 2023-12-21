/*
  Warnings:

  - A unique constraint covering the columns `[id]` on the table `CPU` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[id]` on the table `SystemInfo` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "CPU_id_key" ON "CPU"("id");

-- CreateIndex
CREATE UNIQUE INDEX "SystemInfo_id_key" ON "SystemInfo"("id");
