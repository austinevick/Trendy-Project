import mongoose from "mongoose";

const postSchema = new mongoose.Schema({
    mediaType: {
        type: String,
        enum: ['image', 'video']
    },
    mediaUrl: { type: String },
    hashtags: { type: [String] },
    author: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
    likes: [{ type: mongoose.Schema.Types.ObjectId, ref: 'User' }],
    repost: [{ type: mongoose.Schema.Types.ObjectId, ref: 'User' }],
    comments: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Comments' }],
},
    {
        timestamps: true
    });

const Post = mongoose.model('Post', postSchema);

export default Post;