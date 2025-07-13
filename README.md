# Kafka Monitoring Dashboard

A complete beginner-friendly Kafka monitoring solution using Docker Compose. This project sets up Apache Kafka with Prometheus, Grafana, and Kafka Exporter for comprehensive monitoring and visualization.

## 🚀 What's Included

- **Apache Kafka** - Distributed streaming platform
- **Zookeeper** - Required for Kafka coordination
- **Kafka Exporter** - Exports Kafka metrics for Prometheus
- **Prometheus** - Metrics collection and storage
- **Grafana** - Visualization dashboard
- **Sample Producer/Consumer** - For testing and generating metrics

## 📊 Dashboard Features

The Grafana dashboard includes:

- **Message Throughput** - Messages per second
- **Total Messages** - Current offset tracking
- **Consumer Group Members** - Active consumer monitoring
- **Consumer Lag** - Lag between producer and consumer
- **Topic Partition Leaders** - Partition leadership status
- **System Stats** - Brokers, partitions, consumer groups, replicas

## 🛠️ Prerequisites

### Required Software

1. **Docker Desktop** (or Docker Engine)
   - **Windows/macOS**: Download from https://www.docker.com/products/docker-desktop
   - **Linux**: Install via package manager or Docker's installation script
   - **Verify installation**: `docker --version`

2. **Docker Compose**
   - Usually included with Docker Desktop
   - **Verify installation**: `docker-compose --version`

### System Requirements

- **RAM**: At least 4GB available (8GB recommended)
- **Storage**: At least 2GB free space for Docker images
- **Ports**: 2181, 9092, 3000, 9090, 9308 must be available
- **OS**: Windows 10+, macOS 10.14+, or Linux

### Pre-Setup Checklist

Before starting, ensure:
- [ ] Docker is installed and running
- [ ] Docker Compose is available
- [ ] No other services are using the required ports
- [ ] You have sufficient disk space
- [ ] Your firewall allows Docker connections

### Port Requirements

The following ports will be used:
- **2181**: Zookeeper
- **9092**: Kafka (external access)
- **3000**: Grafana dashboard
- **9090**: Prometheus
- **9308**: Kafka Exporter metrics

## 🚀 Quick Start

### Option 1: Automated Setup (Recommended for Beginners)

1. **Make the setup script executable:**
   ```bash
   chmod +x setup.sh
   ```

2. **Run the automated setup:**
   ```bash
   ./setup.sh
   ```

3. **Wait for completion** - The script will:
   - Check if Docker is installed
   - Verify port availability
   - Start all services
   - Show service status
   - Provide access URLs

### Option 2: Manual Setup

1. **Clone and navigate to the project:**
   ```bash
   cd kafka-monitoring-dashboard
   ```

2. **Start all services:**
   ```bash
   docker-compose up -d
   ```

3. **Wait for services to initialize (2-3 minutes):**
   ```bash
   docker-compose logs -f
   ```

4. **Access the monitoring tools:**
   - **Grafana Dashboard:** http://localhost:3000 (admin/admin)
   - **Prometheus:** http://localhost:9090
   - **Kafka Exporter:** http://localhost:9308/metrics

### 🎯 What Happens During Setup

1. **Docker Images Download** (first time only):
   - Kafka and Zookeeper images (~500MB)
   - Prometheus image (~100MB)
   - Grafana image (~200MB)
   - Kafka Exporter image (~50MB)

2. **Services Start in Order**:
   - Zookeeper (Kafka dependency)
   - Kafka broker
   - Kafka Exporter
   - Prometheus
   - Grafana
   - Sample producer/consumer

3. **Initialization Process**:
   - Kafka creates internal topics
   - Sample producer creates test topic
   - Prometheus starts collecting metrics
   - Grafana loads dashboard

### ⏱️ Expected Timeline

- **0-30 seconds**: Docker images start downloading
- **30-60 seconds**: Services begin starting
- **1-2 minutes**: Kafka and Zookeeper fully initialized
- **2-3 minutes**: All services ready, metrics flowing
- **3+ minutes**: Dashboard shows real data

## 🎯 First Time Setup Guide

### Step 1: Install Docker (if not already installed)

**For Windows:**
1. Download Docker Desktop from https://www.docker.com/products/docker-desktop
2. Install and restart your computer
3. Start Docker Desktop
4. Verify installation: Open Command Prompt and run `docker --version`

**For macOS:**
1. Download Docker Desktop from https://www.docker.com/products/docker-desktop
2. Install and start Docker Desktop
3. Verify installation: Open Terminal and run `docker --version`

**For Linux (Ubuntu/Debian):**
```bash
# Update package index
sudo apt-get update

# Install prerequisites
sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release

# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add Docker repository
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Add user to docker group
sudo usermod -aG docker $USER

# Start Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Verify installation
docker --version
```

### Step 2: Download the Project

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/kafka-monitoring-dashboard.git
   cd kafka-monitoring-dashboard
   ```

2. **Or download as ZIP:**
   - Click "Code" → "Download ZIP" on GitHub
   - Extract the ZIP file
   - Open terminal/command prompt in the extracted folder

### Step 3: Run the Setup

**Option A: Automated Setup (Recommended)**
```bash
# Make script executable (Linux/macOS only)
chmod +x setup.sh

# Run the setup
./setup.sh
```

**Option B: Manual Setup**
```bash
# Start all services
docker-compose up -d

# Monitor the startup process
docker-compose logs -f
```

### Step 4: Verify Everything is Working

1. **Check service status:**
   ```bash
   docker-compose ps
   ```
   All services should show "Up" status.

2. **Access Grafana Dashboard:**
   - Open browser: http://localhost:3000
   - Login: admin / admin
   - You should see the "Kafka Monitoring Dashboard"

3. **Check Prometheus:**
   - Open browser: http://localhost:9090
   - Go to Status → Targets
   - All targets should show "UP" status

4. **Verify Kafka Exporter:**
   - Open browser: http://localhost:9308/metrics
   - Should show Kafka metrics in text format

### Step 5: Understanding What You See

**In Grafana Dashboard:**
- **Message Throughput**: Should show ~0.2 messages/sec (from sample producer)
- **Consumer Lag**: Should show some lag (difference between producer and consumer)
- **Active Brokers**: Should show 1 (single broker setup)
- **Total Partitions**: Should show 3 (test-topic has 3 partitions)

**If metrics are not showing:**
- Wait 2-3 minutes for full initialization
- Check `docker-compose logs -f` for errors
- Verify all services are running with `docker-compose ps`

## 📈 Understanding the Dashboard

### Key Metrics Explained

#### 1. Message Throughput
- **Query:** `rate(kafka_topic_partition_current_offset{topic="test-topic"}[5m])`
- **What it shows:** Messages per second being produced
- **Why it matters:** Indicates system activity and load

#### 2. Consumer Lag
- **Query:** `kafka_consumer_lag_sum{group="test-consumer-group"}`
- **What it shows:** Number of unprocessed messages
- **Why it matters:** High lag indicates consumer issues or overload

#### 3. Active Brokers
- **Query:** `kafka_brokers`
- **What it shows:** Number of healthy Kafka brokers
- **Why it matters:** Ensures high availability and fault tolerance

#### 4. Consumer Group Members
- **Query:** `kafka_consumer_group_members`
- **What it shows:** Number of active consumers in groups
- **Why it matters:** Monitors consumer health and scaling

## 🔍 Useful Prometheus Queries

### Basic Metrics
```promql
# Total messages in a topic
kafka_topic_partition_current_offset{topic="test-topic"}

# Messages per second (rate)
rate(kafka_topic_partition_current_offset{topic="test-topic"}[5m])

# Consumer lag
kafka_consumer_lag_sum{group="test-consumer-group"}

# Number of brokers
kafka_brokers

# Number of partitions
kafka_topic_partitions
```

### Advanced Queries
```promql
# Average lag per partition
avg(kafka_consumer_lag{group="test-consumer-group"})

# Maximum lag across all partitions
max(kafka_consumer_lag{group="test-consumer-group"})

# Messages per second by partition
rate(kafka_topic_partition_current_offset{topic="test-topic"}[5m])

# Consumer group health
kafka_consumer_group_members{group="test-consumer-group"}
```

## 🧪 Testing the Setup

The project includes sample producer and consumer containers that automatically:

1. **Create a test topic** (`test-topic`) with 3 partitions
2. **Generate sample messages** every 5 seconds
3. **Consume messages** to demonstrate consumer lag

### Manual Testing

You can also test manually using the Kafka CLI:

```bash
# Connect to Kafka container
docker exec -it kafka bash

# List topics
kafka-topics --list --bootstrap-server localhost:29092

# Produce a message
echo "Hello Kafka!" | kafka-console-producer --topic test-topic --bootstrap-server localhost:29092

# Consume messages
kafka-console-consumer --topic test-topic --bootstrap-server localhost:29092 --from-beginning
```

## 📅 Daily Usage Guide

### Starting the System

**Every time you want to use the monitoring dashboard:**

```bash
# Navigate to project directory
cd kafka-monitoring-dashboard

# Start all services
docker-compose up -d

# Check status
docker-compose ps
```

### Accessing the Dashboard

1. **Open Grafana**: http://localhost:3000
   - Username: `admin`
   - Password: `admin`

2. **Navigate to Dashboard**:
   - Click the hamburger menu (☰) in the top-left
   - Go to "Dashboards" → "Browse"
   - Click on "Kafka Monitoring Dashboard"

3. **Understanding the Dashboard**:
   - **Time Range**: Use the time picker in the top-right to adjust the time window
   - **Refresh Rate**: Dashboard auto-refreshes every 5 seconds
   - **Panels**: Click on any panel to see detailed metrics

### Monitoring Your Own Kafka Applications

**To monitor your own applications:**

1. **Connect your producer to Kafka**:
   ```bash
   # External connection (from your host machine)
   localhost:9092
   
   # Internal connection (from other Docker containers)
   kafka:29092
   ```

2. **Create your own topics**:
   ```bash
   # Connect to Kafka container
   docker exec -it kafka bash
   
   # Create a new topic
   kafka-topics --create --topic my-topic --bootstrap-server localhost:29092 --partitions 3 --replication-factor 1
   
   # List all topics
   kafka-topics --list --bootstrap-server localhost:29092
   ```

3. **Produce messages to your topic**:
   ```bash
   # From your application or manually
   echo "My message" | kafka-console-producer --topic my-topic --bootstrap-server localhost:9092
   ```

4. **Update dashboard queries**:
   - In Grafana, edit the dashboard
   - Change `topic="test-topic"` to `topic="my-topic"` in queries
   - Save the dashboard

### Stopping the System

```bash
# Stop all services
docker-compose down

# Stop and remove all data (clean slate)
docker-compose down -v
```

### Checking System Health

**Quick health check:**
```bash
# Check if all services are running
docker-compose ps

# View recent logs
docker-compose logs --tail=50

# Check specific service logs
docker-compose logs kafka
docker-compose logs prometheus
docker-compose logs grafana
```

**Verify metrics are flowing:**
1. Open http://localhost:9090 (Prometheus)
2. Go to "Graph" tab
3. Enter query: `kafka_brokers`
4. Click "Execute" - should show value "1"

### Common Daily Tasks

**1. Check Dashboard Health:**
- Open Grafana dashboard
- Verify all panels show data
- Check for any red indicators

**2. Monitor Consumer Lag:**
- Look at "Consumer Lag" panel
- High lag indicates consumer issues
- Normal lag should be low and stable

**3. Check Message Throughput:**
- Monitor "Message Throughput" panel
- Sudden drops may indicate producer issues
- Spikes may indicate high load

**4. Verify Broker Health:**
- "Active Brokers" should always show "1"
- If it shows "0", broker is down

**5. Review System Stats:**
- Check "Total Partitions" and "Consumer Groups"
- These should be stable unless you're adding topics

## 📊 Grafana Dashboard Features

### Real-time Monitoring
- **Auto-refresh:** Dashboard updates every 5 seconds
- **Time range:** Default 15-minute window (adjustable)
- **Multiple panels:** 10 different metric visualizations

### Key Panels
1. **Message Throughput** - Line chart showing messages/sec
2. **Total Messages** - Cumulative message count
3. **Consumer Group Members** - Active consumer count
4. **Consumer Group Current Offset** - Consumer progress
5. **Consumer Lag** - Unprocessed message count
6. **Topic Partition Leaders** - Partition leadership
7. **System Stats** - Brokers, partitions, groups, replicas

## 🔧 Configuration

### Prometheus Configuration
- **File:** `prometheus/prometheus.yml`
- **Scrape interval:** 15 seconds
- **Retention:** 200 hours
- **Targets:** Kafka Exporter (9308), Kafka JMX (9101)

### Grafana Configuration
- **Default credentials:** admin/admin
- **Auto-provisioning:** Datasources and dashboards
- **Dashboard:** Pre-configured Kafka monitoring

### Kafka Configuration
- **Broker ID:** 1
- **Replication factor:** 1 (for single broker)
- **JMX port:** 9101
- **External port:** 9092

## 🚨 Troubleshooting

### Common Issues and Solutions

#### 1. Services Not Starting

**Problem**: `docker-compose up` fails or services show "Exit" status

**Solutions**:
```bash
# Stop all services and clean up
docker-compose down -v

# Remove any dangling containers
docker system prune -f

# Start fresh
docker-compose up -d

# Check logs for specific errors
docker-compose logs kafka
```

**Common causes**:
- Port conflicts (check if other services use the same ports)
- Insufficient memory (need at least 4GB available)
- Docker not running

#### 2. No Metrics in Grafana

**Problem**: Dashboard shows "No data" or empty panels

**Diagnosis**:
```bash
# Check if Prometheus targets are up
curl http://localhost:9090/api/v1/targets

# Check if Kafka Exporter is responding
curl http://localhost:9308/metrics

# Check Prometheus logs
docker-compose logs prometheus
```

**Solutions**:
- Wait 2-3 minutes for full initialization
- Restart Kafka Exporter: `docker-compose restart kafka-exporter`
- Check if Kafka is running: `docker-compose logs kafka`

#### 3. Dashboard Not Loading

**Problem**: Grafana shows error or blank page

**Solutions**:
```bash
# Check Grafana logs
docker-compose logs grafana

# Restart Grafana
docker-compose restart grafana

# Verify Grafana is accessible
curl http://localhost:3000/api/health
```

#### 4. Port Conflicts

**Problem**: "Address already in use" errors

**Diagnosis**:
```bash
# Check what's using the ports
lsof -i :3000  # Grafana
lsof -i :9090  # Prometheus
lsof -i :9092  # Kafka
lsof -i :2181  # Zookeeper
lsof -i :9308  # Kafka Exporter
```

**Solutions**:
- Stop conflicting services
- Or modify ports in `docker-compose.yml`:
  ```yaml
  ports:
    - "3001:3000"  # Change Grafana to port 3001
  ```

#### 5. High Memory Usage

**Problem**: System becomes slow or Docker containers fail

**Solutions**:
```bash
# Check memory usage
docker stats

# Increase Docker memory limit (Docker Desktop)
# Settings → Resources → Memory → Increase to 6GB+

# Or reduce Prometheus retention
# Edit prometheus/prometheus.yml:
# --storage.tsdb.retention.time=50h  # Reduce from 200h
```

#### 6. Slow Dashboard Performance

**Problem**: Dashboard loads slowly or metrics are delayed

**Solutions**:
- Increase Prometheus scrape interval (less frequent updates)
- Reduce Grafana refresh rate (Settings → Dashboard → Auto-refresh)
- Check system resources: `docker stats`

### Advanced Troubleshooting

#### Check Service Health

```bash
# All services status
docker-compose ps

# Individual service health
docker-compose exec kafka kafka-broker-api-versions --bootstrap-server localhost:29092
docker-compose exec prometheus wget -qO- http://localhost:9090/-/healthy
docker-compose exec grafana wget -qO- http://localhost:3000/api/health
```

#### Verify Data Flow

```bash
# Check if Kafka Exporter is collecting metrics
curl http://localhost:9308/metrics | grep kafka_brokers

# Check if Prometheus is scraping
curl http://localhost:9090/api/v1/targets | jq '.data.activeTargets[] | {job: .labels.job, health: .health}'

# Check if Grafana can query Prometheus
curl "http://localhost:3000/api/datasources/proxy/1/api/v1/query?query=kafka_brokers" -u admin:admin
```

#### Reset Everything

```bash
# Complete reset (removes all data)
docker-compose down -v
docker system prune -f
docker volume prune -f
docker-compose up -d
```

### Performance Optimization

#### For Development
```yaml
# Add to docker-compose.yml for faster startup
services:
  kafka:
    environment:
      KAFKA_LOG_RETENTION_HOURS: 1  # Reduce log retention
      KAFKA_LOG_SEGMENT_BYTES: 1073741824  # 1GB segments
```

#### For Production
```yaml
# Add resource limits
services:
  kafka:
    deploy:
      resources:
        limits:
          memory: 2G
        reservations:
          memory: 1G
```

### Useful Commands

```bash
# View all logs
docker-compose logs -f

# View specific service logs
docker-compose logs -f kafka
docker-compose logs -f prometheus
docker-compose logs -f grafana

# Restart specific service
docker-compose restart kafka

# Check service status
docker-compose ps

# Clean up everything
docker-compose down -v

# Check Docker resource usage
docker stats

# View container details
docker-compose exec kafka bash
docker-compose exec prometheus sh
docker-compose exec grafana sh
```

### Getting Help

If you're still having issues:

1. **Check the logs**: `docker-compose logs -f`
2. **Verify Docker is running**: `docker version`
3. **Check system resources**: `docker stats`
4. **Try the setup script**: `./setup.sh`
5. **Review the troubleshooting steps above**

## 📚 Learning Resources

### Kafka Concepts
- **Topics:** Named channels for messages
- **Partitions:** Parallel streams within topics
- **Brokers:** Kafka servers that store data
- **Consumer Groups:** Groups of consumers sharing work
- **Consumer Lag:** Unprocessed message count

### Monitoring Concepts
- **Prometheus:** Time-series database for metrics
- **Grafana:** Visualization platform
- **Kafka Exporter:** Exports Kafka metrics to Prometheus
- **JMX:** Java Management Extensions for Kafka metrics

## 🔄 Scaling and Production

For production use, consider:

1. **Multiple Kafka brokers** for high availability
2. **Increased replication factor** for data safety
3. **Persistent volumes** for data retention
4. **Alerting rules** in Prometheus
5. **Grafana alerts** for critical metrics
6. **Security configurations** (SASL, SSL)

## 📝 License

This project is open source and available under the MIT License.

## 🤝 Contributing

Feel free to submit issues and enhancement requests!

---

**Happy Monitoring! 🎉** 