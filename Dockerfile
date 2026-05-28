FROM python:3.11-slim

# Instalar las herramientas necesarias del sistema para dependencias de Python
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    python3-dev \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Actualizar pip e instalar los requerimientos de la aplicación
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copiar el resto del código del proyecto al contenedor
COPY . .

# Exponer el puerto en el que corre la aplicación Django
EXPOSE 8000

# Comando para arrancar el servidor de desarrollo de PyGoat
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
