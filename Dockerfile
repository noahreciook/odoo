FROM python:3.10

# Instalar dependencias del sistema
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
    node-less \
    npm \
    wkhtmltopdf \
    && apt-get clean

# Crear directorio de trabajo
WORKDIR /odoo

# Copiar dependencias y código
COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

# Puerto por defecto
EXPOSE 8069

CMD ["python3", "odoo-bin", "-c", "odoo.conf"]
