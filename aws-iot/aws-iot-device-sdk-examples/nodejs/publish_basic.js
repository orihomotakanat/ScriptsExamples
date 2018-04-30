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


device.on('connect', function() {
    console.log('connected');
    setInterval( function() {
        device.publish(topic, JSON.stringify({ message: "Hello World"}));
    }, 1000); //per 1sec
});
