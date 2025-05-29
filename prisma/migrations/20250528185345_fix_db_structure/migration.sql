/*
  Warnings:

  - You are about to drop the column `produtor_id` on the `culturas` table. All the data in the column will be lost.
  - You are about to drop the column `ano` on the `safras` table. All the data in the column will be lost.
  - You are about to drop the column `produtor_id` on the `safras` table. All the data in the column will be lost.
  - You are about to drop the `produtores_rurais` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `propriedade_id` to the `culturas` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `culturas` table without a default value. This is not possible if the table is not empty.
  - Added the required column `data_inicio` to the `safras` table without a default value. This is not possible if the table is not empty.
  - Added the required column `nome` to the `safras` table without a default value. This is not possible if the table is not empty.
  - Added the required column `propriedade_id` to the `safras` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `safras` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "culturas" DROP CONSTRAINT "culturas_produtor_id_fkey";

-- DropForeignKey
ALTER TABLE "safras" DROP CONSTRAINT "safras_produtor_id_fkey";

-- AlterTable
ALTER TABLE "culturas" DROP COLUMN "produtor_id",
ADD COLUMN     "propriedade_id" INTEGER NOT NULL,
ADD COLUMN     "updated_at" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "variedade" TEXT;

-- AlterTable
ALTER TABLE "safras" DROP COLUMN "ano",
DROP COLUMN "produtor_id",
ADD COLUMN     "data_fim" TIMESTAMP(3),
ADD COLUMN     "data_inicio" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "nome" TEXT NOT NULL,
ADD COLUMN     "propriedade_id" INTEGER NOT NULL,
ADD COLUMN     "updated_at" TIMESTAMP(3) NOT NULL;

-- DropTable
DROP TABLE "produtores_rurais";

-- CreateTable
CREATE TABLE "produtores" (
    "id" SERIAL NOT NULL,
    "documento" TEXT NOT NULL,
    "tipoDocumento" "TipoDocumento" NOT NULL,
    "nome" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "produtores_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "propriedades" (
    "id" SERIAL NOT NULL,
    "nome" TEXT NOT NULL,
    "cidade" TEXT NOT NULL,
    "estado" TEXT NOT NULL,
    "area_total_ha" DOUBLE PRECISION NOT NULL,
    "area_agricultavel_ha" DOUBLE PRECISION NOT NULL,
    "area_vegetacao_ha" DOUBLE PRECISION NOT NULL,
    "produtor_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "propriedades_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "produtores_documento_key" ON "produtores"("documento");

-- AddForeignKey
ALTER TABLE "propriedades" ADD CONSTRAINT "propriedades_produtor_id_fkey" FOREIGN KEY ("produtor_id") REFERENCES "produtores"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "safras" ADD CONSTRAINT "safras_propriedade_id_fkey" FOREIGN KEY ("propriedade_id") REFERENCES "propriedades"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "culturas" ADD CONSTRAINT "culturas_propriedade_id_fkey" FOREIGN KEY ("propriedade_id") REFERENCES "propriedades"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
