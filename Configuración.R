# Cada que se actualice el código que se genere todo lo siguiente:
system("git config --global commit.gpgSign false")
system("git config --global --list")
system('git commit -m "Actualización para contribuir en GitHub"')
system("git push origin main")


# 1. Configurar globalmente el nombre y correo electrónico
system("git config --global user.name 'AlbertoMadinRivera'")
system("git config --global user.email 'betomadinrivera@gmail.com'")

# 2. Verificar la configuración global
system("git config --global --list")

# 3. Desactivar la firma GPG
system("git config --global commit.gpgSign false")

# 4. Inicializar el repositorio si es necesario (solo la primera vez)
system("git init")

# 5. Agregar el repositorio remoto (si aún no está agregado)
system("git remote add origin https://github.com/AlbertoMadinRivera/GraphGallery_R.git")

# 6. Verificar el remoto configurado (opcional)
system("git remote -v")

# 7. Añadir todos los archivos modificados al staging (o puedes usar git add <archivo>)
system("git add .")

# 8. Realizar el commit con un mensaje
system('git commit -m "Actualización para contribuir en GitHub"')

# 9. Empujar los cambios a GitHub
system("git push origin main")





# Error llave
# Añadir archivos
system("git add .")

# Hacer commit con firma GPG (si ya está configurada)
system('git commit -m "Actualización automática desde R"')

# O hacer commit sin firma GPG
system('git commit -m "Commit sin firma" --no-gpg-sign')

# Empujar al repositorio remoto
system("git push origin main")
