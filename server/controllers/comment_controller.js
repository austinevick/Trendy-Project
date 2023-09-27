import Comments from "../models/comment_model.js";
import httpStatus from 'http-status';
import Blog from "../models/blog_model.js";
import Reply from "../models/reply_model.js";

export const createComment = async (req, res) => {
    try {
        const comment = new Comments(req.body);
        const newData = await comment.save();
        await Blog.findByIdAndUpdate(req.body.blog_id,
            {
                $push: { comments: newData._id },
            },
            { new: true }).exec();

        return res.status(201).json({
            status: httpStatus.CREATED,
            message: 'Success',
        });
    } catch (error) {
        console.log(error.message);
        return res.status(400).json({
            status: httpStatus.BAD_REQUEST,
            message: error.message
        });
    }
};

export const getCommentById = async (req, res) => {
    try {
        const data = await Comments.findById(req.params.id)
            .populate({
                path: 'replies',
                populate: {
                    path: 'replied_by',
                    select: '-password'
                },
            }).exec();
        return res.status(200).json({
            status: httpStatus.OK,
            message: 'Success',
            data: data
        });
    } catch (error) {
        return res.status(404).json({
            status: httpStatus.NOT_FOUND,
            message: error.message,
        });
    }
};

export const getCommentByBlogId = async (req, res) => {
    try {
        const data = await Comments.find({
            "blog_id": { $in: req.params.id }
        }).sort({ datefield: -1 }).
            populate('created_by', ['-password'])
            .populate({
                path: 'replies',
                populate: {
                    path: 'replied_by',
                    select: '-password'
                },
            });

        return res.status(200).json({
            status: httpStatus.OK,
            message: 'Success',
            data: data
        });
    } catch (error) {
        return res.status(404).json({
            status: httpStatus.NOT_FOUND,
            message: error.message
        });
    }
};

export const updateComment = async (req, res) => {
    try {
        await Comments.findByIdAndUpdate(req.params.id,
            {
                $set: {
                    comment: req.body.comment
                }
            });
        return res.status(200).json({
            status: 200,
            message: 'Comments was updated successfully'
        });
    } catch (error) {
        return res.status(404).json({
            status: httpStatus.NOT_FOUND,
            message: error.message
        });
    }
};
export const deleteComment = async (req, res) => {
    try {
        await Comments.findByIdAndDelete(req.params.id);
        return res.status(200).json({
            status: 200,
            message: 'Comments was updated deleted'
        });
    } catch (error) {
        return res.status(404).json({
            status: httpStatus.NOT_FOUND,
            message: error.message
        });
    }
};

export const likesAndUnlikeComment = async (req, res) => {
    try {
        const comment = await Comments.findById(req.body.commentId);
        if (comment.likes.includes(req.params.id)) {
            await Comments.findByIdAndUpdate(req.body.commentId,
                {
                    $pull: { likes: req.params.id }
                }, { new: true }).exec();
            return res.status(200).json({
                status: httpStatus.OK,
                message: 'You unliked this comment'
            });
        } else {
            await Comments.findByIdAndUpdate(req.body.commentId,
                {
                    $push: { likes: req.params.id }
                }, { new: true }).exec();
            return res.status(200).json({
                status: httpStatus.OK,
                message: 'You liked this comment'
            });
        }
    } catch (error) {
        console.log(error.message);
        return res.status(400).json({
            status: httpStatus.BAD_REQUEST,
            message: error.message
        });
    }
};