import Message from "../models/message.js";


export const createMessage = async (req, res) => {
    try {
        const message = new Message(req.body);
        const data = await message.save();
        res.status(201).json({
            status: 201,
            message: 'success',
            data: data
        });
    } catch (error) {
        res.status(500).json({
            status: 500,
            message: error.message
        });
    }
};


export const getMessageById = async (req, res) => {
    try {
        const data = await Message.find({
            conversationId: req.body.conversationId
        });
        res.status(201).json({
            status: 201,
            message: 'success',
            data: data
        });
    } catch (error) {
        res.status(500).json({
            status: 500,
            message: error.message
        });
    }
};