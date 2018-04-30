var awsIot = require('aws-iot-device-sdk');
var awsIoTconfig = require('config');

var device = awsIot.device({
    region: awsIoTconfig.specificConfig.ApNortheast1.region,
    keyPath: awsIoTconfig.specificConfig.ApNortheast1.privateKeyPath,
    certPath: awsIoTconfig.specificConfig.ApNortheast1.certificatePath,
    caPath: awsIoTconfig.specificConfig.ApNortheast1.rootCaPath,
    host: awsIoTconfig.specificConfig.ApNortheast1.host,
    clientId: awsIoTconfig.topicConfig.clientid,
    clean: true,
    offlineQueueing: false,
    baseReconnectTimeMs: 10000,
    will: {topic: 'hello/world', payload: 'LWT', qos: 1, retain: false}, //retain is only false'
    debug: true,
    port: 8883
});

var publishTopic = awsIoTconfig.topicConfig.publish
var subscribeTopic = awsIoTconfig.topicConfig.subscribe

//publish&subscribe
device.on('connect', function() {
    console.log('connected');
    device.subscribe(subscribeTopic, function(error, result) {
      console.log(result)
    });
    setInterval( function() {
        device.publish(publishTopic, JSON.stringify({ message: "Hello World"}));
    }, 1000); //per 1sec
});


// Show subscribed message
device.on('message', function(subscribeTopic, payload) {
    console.log('message', subscribeTopic, payload.toString());
});
