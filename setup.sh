#!/bin/bash

# Kafka Monitoring Dashboard Setup Script
# This script helps you get started with the Kafka monitoring setup

echo "🚀 Kafka Monitoring Dashboard Setup"
echo "=================================="
echo ""

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install Docker first:"
    echo "   https://docs.docker.com/get-docker/"
    exit 1
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose is not installed. Please install Docker Compose first:"
    echo "   https://docs.docker.com/compose/install/"
    exit 1
fi

# Check if ports are available
echo "🔍 Checking if required ports are available..."

PORTS=(2181 9092 3000 9090 9308)
for port in "${PORTS[@]}"; do
    if lsof -Pi :$port -sTCP:LISTEN -t >/dev/null 2>&1; then
        echo "⚠️  Port $port is already in use. Please stop the service using this port or modify docker-compose.yml"
    else
        echo "✅ Port $port is available"
    fi
done

echo ""
echo "📦 Starting Kafka Monitoring Dashboard..."
echo "   This may take 2-3 minutes for all services to initialize."
echo ""

# Start the services
docker-compose up -d

echo ""
echo "⏳ Waiting for services to initialize..."
echo "   You can monitor the logs with: docker-compose logs -f"
echo ""

# Wait a bit and show status
sleep 10

echo "📊 Service Status:"
docker-compose ps

echo ""
echo "🎉 Setup Complete!"
echo "=================="
echo ""
echo "📈 Access your monitoring tools:"
echo "   • Grafana Dashboard: http://localhost:3000 (admin/admin)"
echo "   • Prometheus: http://localhost:9090"
echo "   • Kafka Exporter: http://localhost:9308/metrics"
echo ""
echo "🧪 Test the setup:"
echo "   • The dashboard will show metrics from a sample producer/consumer"
echo "   • Sample messages are generated every 5 seconds"
echo "   • Consumer lag will be visible in the dashboard"
echo ""
echo "📚 Useful commands:"
echo "   • View logs: docker-compose logs -f"
echo "   • Stop services: docker-compose down"
echo "   • Restart: docker-compose restart"
echo ""
echo "🔍 Troubleshooting:"
echo "   • If no metrics appear, wait 2-3 minutes for full initialization"
echo "   • Check service status: docker-compose ps"
echo "   • View specific logs: docker-compose logs -f [service-name]"
echo ""
echo "📖 Read the README.md for detailed instructions and examples!"
echo "" 