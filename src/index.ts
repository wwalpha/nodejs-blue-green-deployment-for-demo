import express from 'express';

const app = express();

app.disable('x-powered-by');

app.get('/', (_, res) => res.send(process.env['Environment']));

app.get('/health', (_, res) => res.send('OK'));

app.listen(8080, () => {
  console.log('started...');
});
