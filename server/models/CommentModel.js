import mongoose from "mongoose";

const commentSchema = new mongoose.Schema({
    comment: { type: String, required: true },
    blog_id: { type: mongoose.Schema.Types.ObjectId, ref: 'Blog' },
    imageUrl: { type: String },
    likes: [{ type: mongoose.Schema.Types.ObjectId, ref: 'User' }],
    replies: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Replies' }],
    created_by: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
},
    {
        timestamps: true
    });

const Comments = mongoose.model('Comments', commentSchema);

export default Comments;


