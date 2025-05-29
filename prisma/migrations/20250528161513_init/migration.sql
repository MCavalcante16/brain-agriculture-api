-- CreateEnum
CREATE TYPE "TipoDocumento" AS ENUM ('CPF', 'CNPJ');

-- CreateTable
CREATE TABLE "produtores_rurais" (
    "id" SERIAL NOT NULL,
    "documento" TEXT NOT NULL,
    "tipoDocumento" "TipoDocumento" NOT NULL,
    "nome" TEXT NOT NULL,
    "nome_fazenda" TEXT NOT NULL,
    "cidade" TEXT NOT NULL,
    "estado" TEXT NOT NULL,
    "area_total_ha" DOUBLE PRECISION NOT NULL,
    "area_agricultavel_ha" DOUBLE PRECISION NOT NULL,
    "area_vegetacao_ha" DOUBLE PRECISION NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "produtores_rurais_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "safras" (
    "id" SERIAL NOT NULL,
    "ano" TEXT NOT NULL,
    "produtor_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "safras_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "culturas" (
    "id" SERIAL NOT NULL,
    "nome" TEXT NOT NULL,
    "safra_id" INTEGER NOT NULL,
    "area_plantada_ha" DOUBLE PRECISION NOT NULL,
    "produtor_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "culturas_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "produtores_rurais_documento_key" ON "produtores_rurais"("documento");

-- AddForeignKey
ALTER TABLE "safras" ADD CONSTRAINT "safras_produtor_id_fkey" FOREIGN KEY ("produtor_id") REFERENCES "produtores_rurais"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "culturas" ADD CONSTRAINT "culturas_safra_id_fkey" FOREIGN KEY ("safra_id") REFERENCES "safras"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "culturas" ADD CONSTRAINT "culturas_produtor_id_fkey" FOREIGN KEY ("produtor_id") REFERENCES "produtores_rurais"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
