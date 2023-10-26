import User from "../models/UserModel.js";


export const sendMessage = async (req, res) => {
    try {
        const { sender, receiver } = req.query;
        const user = await User.find({ email: receiver });
        const filterUser = user[0].messages
            .filter((message) => message.sender === sender && message.receiver === receiver ||
                message.sender === receiver && message.receiver === sender);
        return res.status(200).json({
            status: 200,
            message: 'success',
            data: filterUser
        });
    } catch (error) {
        return res.status(400).json({
            status: 400,
            message: error,
            data: filterUser
        });
    }
};