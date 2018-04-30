var awsIot = require('aws-iot-device-sdk');

var device = awsIot.device({
    region: '<region>',
    keyPath: 'priv.pem.key',
    certPath: 'cer.pem.crt',
    caPath: 'rootCA.crt',
    clientId: 'sample-device',
    host: '<YourEndpoint>.iot.<region>.amazonaws.com',
    debug: true //Debug option
});

topic = 'message/device001'

// Subscription
device.on('connect', function() {
  console.log('connect');
  setInterval(function() {
    device.subscribe(topic, function(error, result) {
        console.log(result)
      });
    }, 30);
});

// Show subscribed message
device.on('message', function(topic, payload) {
  console.log('message', topic, payload.toString());
});
