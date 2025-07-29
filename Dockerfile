FROM python:3.10

# Instala dependencias del sistema
RUN apt-get update && apt-get install -y \
    git \
    libpq-dev \
    gcc \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
    libsasl2-dev \
    libldap2-dev \
    libjpeg-dev \
    libffi-dev \
    node-less \
    npm \
    && rm -rf /var/lib/apt/lists/*

# Instala wkhtmltopdf (reporte PDF)
RUN apt-get update && apt-get install -y \
    wkhtmltopdf

# Instala dependencias Python
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copia el código
COPY . /odoo
WORKDIR /odoo

# Exponer el puerto de Odoo
EXPOSE 8069

CMD ["python3", "odoo/odoo-bin", "-c", "odoo.conf"]
