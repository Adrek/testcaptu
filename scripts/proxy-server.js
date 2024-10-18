const http = require('http');
const httpProxy = require('http-proxy');

// Crea una instancia de un servidor proxy
const proxy = httpProxy.createProxyServer({});

// Crea un servidor HTTP para redirigir las solicitudes
const server = http.createServer((req, res) => {


  if (req.url.startsWith('/auth')) {
    // Redirigir al primer backend y remover el prefijo '/backend1'
    req.url = req.url.replace('/auth', '');
    proxy.web(req, res, { target: 'http://172.29.55.54:8012' });
  } else if (req.url.startsWith('/backend')) {
    // Redirigir al segundo backend y remover el prefijo '/backend'
    req.url = req.url.replace('/backend', '');
    // proxy.web(req, res, { target: 'http://172.29.55.54:8017' });
    proxy.web(req, res, { target: 'http://172.29.170.120:8080' });
  } else {
    res.writeHead(404, { 'Content-Type': 'text/plain' });
    res.end('Not Found');
  }

  /* // Redirige las solicitudes a la IP y puerto del backend de tu amigo
  proxy.web(req, res, { target: 'http://172.29.170.120:8080' }, (error) => {
  // proxy.web(req, res, { target: 'http://172.29.55.54:8017' }, (error) => {
    console.error('Error al redirigir la solicitud:', error);
    res.writeHead(500, { 'Content-Type': 'text/plain' });
    res.end('Error al redirigir la solicitud');
  }); */
});

// Haz que el servidor escuche en el puerto 8080 de tu máquina
server.listen(3090, () => {
  console.log('Server proxy ejecutándose...');
});