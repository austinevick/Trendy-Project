import Comments from "../models/comment_model.js";
import httpStatus from 'http-status';
import Reply from "../models/reply_model.js";

export const replyToComment = async (req, res) => {
    try {
        const reply = new Reply(req.body);
        const data = await reply.save();
        await Comments.findByIdAndUpdate(req.body.comment_id,
            {
                $push: { replies: data._id }
            }, { new: true }
        );
        return res.status(201).json({
            status: httpStatus.CREATED,
            message: 'Success',
            data: data
        });
    } catch (error) {
        console.log(error.message);
        return res.status(400).json({
            status: httpStatus.BAD_REQUEST,
            message: error.message,
        });
    }
};

export const getRepliesByCommentId = async (req, res) => {
    try {
        const data = await Reply.find({
            "comment_id": { $in: req.params.id }
        }).populate('replied_by', ['-password']);
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
