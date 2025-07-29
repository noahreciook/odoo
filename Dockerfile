FROM python:3.10-slim

# Evitar prompts interactivos
ENV DEBIAN_FRONTEND=noninteractive

# Instalar dependencias del sistema necesarias para compilar paquetes de Python
RUN apt-get update && apt-get install -y \
    git \
    gcc \
    build-essential \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
    libsasl2-dev \
    libldap2-dev \
    libjpeg-dev \
    libpq-dev \
    libffi-dev \
    libssl-dev \
    python3-dev \
    node-less \
    npm \
    wkhtmltopdf \
    && apt-get clean

# Crear directorio de trabajo
WORKDIR /odoo

# Copiar el archivo de dependencias e instalar
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt --verbose

# Copiar el resto del código
COPY . .

# Exponer el puerto de Odoo
EXPOSE 8069

# Comando para iniciar Odoo
CMD ["python3", "odoo-bin", "-c", "odoo.conf"]
