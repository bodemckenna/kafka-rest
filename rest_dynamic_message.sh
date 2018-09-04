# Get a list of topics
echo "List all topics"
curl "http://cp-kafka.icon.seli.gic.ericsson.se/topics"
echo ""
sleep 5
 
# Get info about one topic
echo "Get info about topic colm_test_rest"
curl "http://cp-kafka.icon.seli.gic.ericsson.se/topics/dynamic_rest"
echo ""
sleep 5
 
#Creating messages
echo "Creating 10000 messages"
date +"%T.%N"
curl -X POST -H "Content-Type: application/vnd.kafka.json.v2+json" --data '{"records":[{"value":{"name": "testUser'$i'"}}]}' "http://cp-kafka.icon.seli.gic.ericsson.se/topics/dynamic_rest/?[0-10000]" -w "%{time_connect},%{time_total},%{speed_download},%{http_code},%{size_download},%{url_effective}\n"
date +"%T.%N"
 
#curl -X POST -H "Content-Type: application/vnd.kafka.json.v2+json" --data '{"records":[{"value":{"name": "testUser"}}]}' "http://cp-kafka.rontgen002.seli.gic.ericsson.se/topics/colm_test_rest"
 
#Create a consumer for JSON data, The consumer group is called "my_json_consumer" and the instance is "my_consumer_instance".
echo "Create a consumer"
curl -X POST -H "Content-Type: application/vnd.kafka.v2+json" -H "Accept: application/vnd.kafka.v2+json"     --data '{"name": "my_consumer_instance", "format": "json", "auto.offset.reset": "earliest"}'     http://cp-kafka.icon.seli.gic.ericsson.se/consumers/my_json_consumer
sleep 5
echo ""
 
#subscribe the consumer to a topic
echo "subscribe the consumer to a topic"
curl -X POST -H "Content-Type: application/vnd.kafka.v2+json" --data '{"topics":["dynamic_rest"]}' http://cp-kafka.icon.seli.gic.ericsson.se/consumers/my_json_consumer/instances/my_consumer_instance/subscription
 
sleep 15
#consumer some data from a topic
echo "Consuming data from topic"
echo ""
curl -X GET -H "Accept: application/vnd.kafka.json.v2+json"   http://cp-kafka.icon.seli.gic.ericsson.se/consumers/my_json_consumer/instances/my_consumer_instance/records
echo ""
curl -X GET -H "Accept: application/vnd.kafka.json.v2+json"   http://cp-kafka.icon.seli.gic.ericsson.se/consumers/my_json_consumer/instances/my_consumer_instance/records
echo ""
curl -X GET -H "Accept: application/vnd.kafka.json.v2+json"   http://cp-kafka.icon.seli.gic.ericsson.se/consumers/my_json_consumer/instances/my_consumer_instance/records
echo ""
 
#Delete the consumer
echo "Deleting the consumer"
curl -X DELETE -H "Accept: application/vnd.kafka.v2+json" http://cp-kafka.icon.seli.gic.ericsson.se/consumers/my_json_consumer/instances/my_consumer_instance
echo "Done"
