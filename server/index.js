import express from 'express';
import dotenv from 'dotenv';
import connection from './config/db.js';
import router from './routes/router.js';
import cors from 'cors';
dotenv.config();
const app = express();
app.use(cors());
app.use(express.json());
app.use(express.raw());
app.use(express.urlencoded({ extended: true, limit: '50mb' }));
app.use('/api', router);


const port = process.env.PORT || 5000;
app.listen(port, async () => {
    await connection();
    console.log(`Server running on http://localhost:${ port }`);
});
