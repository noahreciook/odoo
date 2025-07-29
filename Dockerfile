FROM python:3.10-slim

# Evitar prompts interactivos
ENV DEBIAN_FRONTEND=noninteractive

# Instalar dependencias del sistema necesarias para compilar paquetes y ejecutar Odoo
RUN apt-get update && apt-get install -y \
    gcc \
    build-essential \
    python3-dev \
    libxml2-dev \
    libxslt1-dev \
    libjpeg-dev \
    libpq-dev \
    libffi-dev \
    libssl-dev \
    libsasl2-dev \
    libldap2-dev \
    libev-dev \
    node-less \
    npm \
    wkhtmltopdf \
    git \
    curl \
    && apt-get clean

# Crear directorio de trabajo
WORKDIR /odoo

# Copiar el archivo de dependencias primero
COPY requirements.txt .

# Actualizar pip, instalar Cython primero, luego instalar el resto
RUN pip install --upgrade pip
RUN pip install cython
RUN pip install --no-cache-dir -r requirements.txt

# Copiar el resto del código fuente de Odoo
COPY . .

# Exponer el puerto de Odoo
EXPOSE 8069

# Comando por defecto para iniciar Odoo
CMD ["python3", "odoo-bin", "-c", "odoo.conf"]
