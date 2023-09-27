import Conversation from '../models/conversation.js';

export const createConversation = async (req, res) => {
    const newConversation = new Conversation({
        members: [req.body.senderId,
        req.body.receiverId]
    });
    try {
        const data = await newConversation.save();
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

export const getConversationByUserId = async (req, res) => {
    try {
        const data = await Conversation.find({
            members: { $in: [req.params.id] }
        });
        res.status(200).json({
            status: 200,
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