FROM python:3.10

# Instalar dependencias del sistema necesarias para compilar paquetes
RUN apt-get update && apt-get install -y \
    git \
    gcc \
    python3-dev \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
    libsasl2-dev \
    libldap2-dev \
    libjpeg-dev \
    libpq-dev \
    libffi-dev \
    libssl-dev \
    node-less \
    npm \
    wkhtmltopdf \
    && apt-get clean

# Establecer directorio de trabajo
WORKDIR /odoo

# Copiar todo el proyecto primero
COPY . .

# Actualizar pip y luego instalar dependencias Python
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Exponer el puerto por defecto de Odoo
EXPOSE 8069

# Comando por defecto para iniciar Odoo
CMD ["python3", "odoo-bin", "-c", "odoo.conf"]
