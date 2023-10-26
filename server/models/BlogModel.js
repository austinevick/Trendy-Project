import mongoose from "mongoose";

const blogSchema = new mongoose.Schema({
    content: { type: String },
    mediaType: {
        type: String,
        enum: ['null', 'image', 'video']
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

const Blog = mongoose.model('Blog', blogSchema);

export default Blog;