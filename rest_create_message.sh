curl -X POST -H "Content-Type: application/vnd.kafka.json.v2+json" \
          --data '{"records":[{"value":{"name": "testUser"}}]}' \
          "http:/// http://cp-kafka.rontgen002.seli.gic.ericsson.setopics/colm_test_rest"
