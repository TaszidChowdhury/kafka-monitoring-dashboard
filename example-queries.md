# Example Prometheus Queries for Kafka Monitoring

This file contains useful Prometheus queries you can use in Grafana or directly in Prometheus for monitoring Kafka.

## 📊 Basic Metrics

### Message Throughput
```promql
# Messages per second for a specific topic
rate(kafka_topic_partition_current_offset{topic="test-topic"}[5m])

# Messages per second for all topics
rate(kafka_topic_partition_current_offset[5m])
```

### Total Messages
```promql
# Total messages in a topic
kafka_topic_partition_current_offset{topic="test-topic"}

# Total messages across all topics
sum(kafka_topic_partition_current_offset)
```

### Consumer Lag
```promql
# Consumer lag for a specific group
kafka_consumer_lag_sum{group="test-consumer-group"}

# Consumer lag per partition
kafka_consumer_lag{group="test-consumer-group"}

# Average lag across all partitions
avg(kafka_consumer_lag{group="test-consumer-group"})

# Maximum lag across all partitions
max(kafka_consumer_lag{group="test-consumer-group"})
```

## 🏥 Health Metrics

### Broker Health
```promql
# Number of active brokers
kafka_brokers

# Broker is up (1 = healthy, 0 = unhealthy)
kafka_brokers > 0
```

### Topic Health
```promql
# Number of partitions per topic
kafka_topic_partitions

# Number of replicas per topic
kafka_topic_partition_replicas

# Partition leaders
kafka_topic_partition_leader
```

### Consumer Health
```promql
# Number of consumer group members
kafka_consumer_group_members{group="test-consumer-group"}

# Consumer group current offset
kafka_consumer_group_current_offset{group="test-consumer-group"}

# Consumer group lag
kafka_consumer_lag_sum{group="test-consumer-group"}
```

## 📈 Performance Metrics

### Throughput Analysis
```promql
# Messages per second by partition
rate(kafka_topic_partition_current_offset{topic="test-topic"}[5m])

# Bytes per second (if available)
rate(kafka_topic_partition_current_offset_bytes{topic="test-topic"}[5m])
```

### Lag Analysis
```promql
# Lag percentage (lag / total messages)
(kafka_consumer_lag_sum{group="test-consumer-group"} / kafka_topic_partition_current_offset{topic="test-topic"}) * 100

# Lag trend (increasing/decreasing)
deriv(kafka_consumer_lag_sum{group="test-consumer-group"}[5m])
```

### System Load
```promql
# Total partitions across all topics
sum(kafka_topic_partitions)

# Total consumer groups
kafka_consumer_groups

# Total replicas
sum(kafka_topic_partition_replicas)
```

## 🚨 Alerting Queries

### High Consumer Lag Alert
```promql
# Alert when lag > 1000 messages
kafka_consumer_lag_sum{group="test-consumer-group"} > 1000
```

### Broker Down Alert
```promql
# Alert when no brokers are available
kafka_brokers == 0
```

### Consumer Group Issues
```promql
# Alert when consumer group has no members
kafka_consumer_group_members{group="test-consumer-group"} == 0
```

### High Throughput Alert
```promql
# Alert when throughput > 1000 messages/sec
rate(kafka_topic_partition_current_offset{topic="test-topic"}[5m]) > 1000
```

## 📊 Advanced Analytics

### Partition Distribution
```promql
# Messages per partition
kafka_topic_partition_current_offset{topic="test-topic"}

# Partition leader distribution
kafka_topic_partition_leader{topic="test-topic"}
```

### Consumer Group Analysis
```promql
# Consumer group lag by partition
kafka_consumer_lag{group="test-consumer-group"}

# Consumer group offset by partition
kafka_consumer_group_current_offset{group="test-consumer-group"}
```

### Topic Growth
```promql
# Topic growth rate (messages per minute)
rate(kafka_topic_partition_current_offset{topic="test-topic"}[1m]) * 60
```

## 🔍 Troubleshooting Queries

### Missing Metrics
```promql
# Check if Kafka Exporter is working
up{job="kafka-exporter"}

# Check if Prometheus can scrape Kafka Exporter
kafka_brokers
```

### Performance Issues
```promql
# Check for partition imbalance
max(kafka_topic_partition_current_offset{topic="test-topic"}) - min(kafka_topic_partition_current_offset{topic="test-topic"})

# Check consumer lag distribution
max(kafka_consumer_lag{group="test-consumer-group"}) - min(kafka_consumer_lag{group="test-consumer-group"})
```

## 💡 Tips for Using These Queries

1. **Time Ranges**: Use `[5m]` for rate calculations to get smooth averages
2. **Labels**: Use specific topic and group names for targeted monitoring
3. **Aggregation**: Use `sum()`, `avg()`, `max()`, `min()` for different views
4. **Comparison**: Use `>` and `<` operators for alerting
5. **Trends**: Use `deriv()` to see if metrics are increasing/decreasing

## 🎯 Common Use Cases

### Monitoring Production Kafka
- Set up alerts for high consumer lag
- Monitor broker health continuously
- Track message throughput trends
- Watch for partition imbalances

### Debugging Issues
- Check consumer group member count
- Analyze lag patterns
- Monitor topic growth
- Verify broker connectivity

### Capacity Planning
- Track message volume growth
- Monitor partition usage
- Analyze consumer performance
- Plan scaling based on metrics 