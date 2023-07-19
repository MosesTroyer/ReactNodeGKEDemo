import 'dotenv/config'
import express, { Request, Response } from 'express';
import path from 'path';

const cors = require('cors');

const server = express();

server.use(express.json());
server.use('/', express.static(path.join(__dirname, 'public')));

if (process.env.NODE_ENV !== 'production') {
    server.use(cors({ origin: 'http://localhost:3000' , credentials :  true}));
}

server.get('/api/test', (req: Request, res: Response) => {
   res
       .status(200)
       .send('Api Test Functional')
});

export default server;