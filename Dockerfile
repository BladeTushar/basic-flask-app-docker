# Stage 1 - Builder
FROM python:3.7 AS builder

WORKDIR /app
COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

# Stage 2 - Final (relatively smaller img)
FROM python:3.7-slim

WORKDIR /app

# Copy installed packages from builder
COPY --from=builder /usr/local/lib/python3.7/site-packages/ /usr/local/lib/python3.7/site-packages/

# Copy app source code
COPY . .
#attaching it to the port
# Expose port (change if your Flask app uses 5000)
EXPOSE 80

# Run the app 
CMD ["python", "run.py"] 
