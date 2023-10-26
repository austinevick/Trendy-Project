import express from 'express';
import dotenv from 'dotenv';
import connection from './config/db.js';
import router from './routes/router.js';
import cors from 'cors';
import http from 'http';
import { Server } from 'socket.io';
import User from './models/UserModel.js';
import jwt from 'jsonwebtoken';
dotenv.config();
const app = express();
const server = http.createServer(app);
app.use(cors());
app.use(express.json());
app.use(express.raw());
app.use(express.urlencoded({ extended: true, limit: '50mb' }));
app.use('/api', router);


const port = process.env.PORT || 5000;
server.listen(port, async () => {
    await connection();
    console.log(`Server running on http://localhost:${ port }`);
});

const io = new Server(server, {
    cors: { origin: "http://localhost:3000" }
});

io.on('connection', (socket) => {
    console.log(socket.id);
    socket.on('private.message', async (to, message, mySelf) => {
        const user = await User.find({ _id: to });
        const decoded = jwt.verify(mySelf, process.env.JWT_SECRET);
        const sender = await User.findById(decoded);
        io.sockets.emit('refresh', 'new message');
        if (user) {
            user[0].messages.push({
                receiver: user[0].email,
                message: message,
                sender: sender.email,
                time: new Date()
            });
            sender?.messages.push({
                receiver: user[0].email,
                message: message,
                sender: sender.email,
                time: new Date()
            });
            await user[0].save();
            await sender[0].save();
        }
    });
});