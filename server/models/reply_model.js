import mongoose from "mongoose";


const replySchema = new mongoose.Schema({
    reply: { type: String, required: true },
    comment_id: { type: mongoose.Schema.Types.ObjectId, ref: 'Comments' },
    likes: [{ type: mongoose.Schema.Types.ObjectId, ref: 'User' }],
    replied_by: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
}, {
    timestamps: true
});

const Reply = mongoose.model('Replies', replySchema);

export default Reply;