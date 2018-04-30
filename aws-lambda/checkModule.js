'use strict';

const exec = require('child_process').exec;

const command = 'cd ../; ls -a'; //Add shell command

exports.handler = (event, context, callback) => {

    const child = exec(command, (error) => {
        // Resolve with result of process
        callback(error, 'Process complete!');
    });

    // Log process stdout and stderr
    child.stdout.on('data', console.log);
    child.stderr.on('data', console.error);
};
