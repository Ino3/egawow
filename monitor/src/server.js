const Hapi = require('hapi');
const server = Hapi.Server({
    port: 3000,
    host: 'localhost',
});

const io = require('socket.io')(server.listener);
const fs = require('fs');

// server.route({
//     method: 'GET',
//     path: '/',
//     handler: (request, h) => {
//         return h.file('./src/index.html');
//     }
// });

// chatでメッセージを受信したらクライアント全体にキャスト
io.on('connection', (socket) => {
    socket.on('emotion', (msg) => {
        io.emit('emotion', msg);
    });
});


server.route({
    method: 'GET',
    path: '/',
    handler: function (request, h) {
        const emotion = JSON.stringify(
        {
            "emotion": {
                "anger": 0.898,
                "contempt": 0.002,
                "disgust": 0.002,
                "fear": 0.005,
                "happiness": 0,
                "neutral": 0.001,
                "sadness": 0.009,
                "surprise": 0.076
            }
        }
        );

        return h.view('index', emotion);
    }
});

server.route({
    method: 'POST',
    path: '/',
    handler: (request, h) => {
        const payload = request.payload;
        console.log(payload);

        io.sockets.emit('emotion', payload);

        return payload;
    }
});



const init = async () => {
    await server.register(require('inert'));

    await server.register(require('vision'));

    server.views({
        engines: {
            html: require('handlebars')
        },
        relativeTo: __dirname,
        path: 'templates',
        helpersPath: 'templates/helpers'
    });
    await server.start();
    console.log(`Server running at: ${server.info.uri}`);
};


// io.on('connection', function (socket) {
//     // クライアントへデータ送信
//     // emit を使うとイベント名を指定できる
//     socket.emit('news', { hello: 'world' });
//     socket.on('my other event', function (data) {
//         // クライアントから受け取ったデータを出力する
//         console.log(data);
//     });
// });

init();