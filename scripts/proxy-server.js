const http = require('http');
const httpProxy = require('http-proxy');

// Crea una instancia de un servidor proxy
const proxy = httpProxy.createProxyServer({});

// Crea un servidor HTTP para redirigir las solicitudes
const server = http.createServer((req, res) => {
  // Redirige las solicitudes a la IP y puerto del backend de tu amigo
  proxy.web(req, res, { target: 'http://172.29.170.120:8080' }, (error) => {
  // proxy.web(req, res, { target: 'http://172.29.55.54:8017' }, (error) => {
    console.error('Error al redirigir la solicitud:', error);
    res.writeHead(500, { 'Content-Type': 'text/plain' });
    res.end('Error al redirigir la solicitud');
  });
});

// Haz que el servidor escuche en el puerto 8080 de tu máquina
server.listen(3090, () => {
  console.log('Server proxy ejecutándose...');
});