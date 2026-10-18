
FROM python:3.12-slim

# Set the working directory
WORKDIR /app

# Prevent Python from writing bytecode and buffer logs
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install dependencies first for better build caching
COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

# Copy application source code
COPY app.py .

# Document the application port
EXPOSE 5020

# Run as a non-root user
RUN useradd --create-home appuser
USER appuser

# Start the Flask application with Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:5020", "app:app"]
