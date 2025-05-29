# Salve como prisma-fix.ps1 e execute como Administrador
Write-Host "Limpando ambiente Prisma..." -ForegroundColor Yellow

Remove-Item -Recurse -Force node_modules\.prisma
Remove-Item -Recurse -Force node_modules\@prisma\client
npm cache clean --force
npm install
npx prisma generate
npx prisma migrate dev
npm run build

Write-Host "Prisma reinicializado com sucesso!" -ForegroundColor Green