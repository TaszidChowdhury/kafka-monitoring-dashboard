# Kafka Monitoring Dashboard

---

## 🚦 How to Use This Project

1. **Start the System**
   ```bash
   docker compose up -d
   ```
   This starts Kafka, Zookeeper, Prometheus, Grafana, Kafka Exporter, and sample producer/consumer.

2. **Wait for Initialization**
   - First run may take 2–3 minutes (images download, services start)
   - Watch logs (optional):
     ```bash
     docker compose logs -f
     ```

3. **Access the Dashboards**
   - **Grafana:** [http://localhost:3000](http://localhost:3000) (login: `admin` / `admin`)
   - **Prometheus:** [http://localhost:9090](http://localhost:9090)
   - **Kafka Exporter metrics:** [http://localhost:9308/metrics](http://localhost:9308/metrics)

4. **View Kafka Metrics**
   - In Grafana, open the “Kafka Monitoring Dashboard”
   - See panels for message throughput, consumer lag, broker health, and more
   - Dashboard auto-refreshes every 5 seconds

5. **Stop the System**
   ```bash
   docker compose down
   ```

6. **Monitor Your Own Topics**
   - Produce/consume to Kafka at `localhost:9092` (from your machine) or `kafka:29092` (from other containers)
   - Create new topics using the Kafka CLI (see below or in the README)
   - Edit the Grafana dashboard to monitor your own topics/groups

---

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
   ```