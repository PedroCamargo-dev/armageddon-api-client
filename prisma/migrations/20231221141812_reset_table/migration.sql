/*
  Warnings:

  - A unique constraint covering the columns `[id]` on the table `Memory` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "Memory_id_key" ON "Memory"("id");
