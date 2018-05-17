'use strict';

const Hapi          = require( 'hapi' ),
      fs            = require( 'fs' ),
      HAPIWebSocket = require( "hapi-plugin-websocket" ),
//      HAPIAuthBasic = require( "hapi-auth-basic" ),
      WebSocket     = require( "ws" );


const server = Hapi.server({
    port: 3000,
    host: 'localhost',
    mime: {
        override: {
            'application/json': {
                source    : 'iana',
                charset   : 'UTF-8',
                // compressible: true,
                extensions: [ 'json' ],
                type      : 'application/json'
            }
        }
    }
});



const init = async () => {
    await server.register(HAPIWebSocket);


    await server.start();
    console.log(`Server running at: ${server.info.uri}`);
};

/*  provide combined REST/WebSocket route  */
server.route({
    method: "POST", path: "/bar",
    config: {
        payload: { output: "data", parse: true, allow: "application/json" },
        plugins: { websocket: true }
    },
    handler: (request, h) => {
        let { mode } = request.websocket();
        return { at: "bar", mode: mode, seen: request.payload }
    }
});




server.route({
    method: 'GET',
    path: '/',
    handler: (request, h) => {

        let emotion = fs.readFileSync('./src/emotion.json', 'utf8');
        console.log(emotion);

        let response = h.response(emotion);
        response.type('application/json');
        return response;
    }
});

server.route({
    method: 'POST',
    path: '/',
    handler: (request, h) => {
        const payload = request.payload;
        console.log(payload);
        fs.writeFileSync('./src/emotion.json', JSON.stringify(payload, null,  '    '));

        return payload;
    }
});



process.on('unhandledRejection', (err) => {

    console.log(err);
    process.exit(1);
});

init();
