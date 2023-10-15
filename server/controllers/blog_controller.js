import Blog from '../models/blog_model.js';
import httpStatus from 'http-status';
import mongoose, { Query } from 'mongoose';
import User from '../models/user_model.js';
import { query } from 'express';

export const createBlog = async (req, res) => {
    try {
        console.log(req.body);
        const blog = new Blog(req.body);
        const id = await blog.save();

        return res.status(201).json({
            status: httpStatus.CREATED,
            message: 'Your post has been uploaded successfully',

        });
    } catch (error) {
        console.log(error.message);
        return res.status(400).json({
            status: httpStatus.BAD_REQUEST,
            message: error.message,
        });
    }
};

export const getBlogById = async (req, res) => {
    try {
        const data = await Blog.findById(req.params.id).sort({ datefield: -1 })
            .populate({
                path: 'comments',
                populate: { path: 'created_by' },
                options: { sort: { 'created_at': -1 } }
            }).populate({
                path: 'author',
                select: '-password'
            });
        return res.status(200).json({
            status: httpStatus.OK,
            message: 'Success',
            data: data
        });
    } catch (error) {
        console.log(error.message);
        return res.status(404).json({
            status: httpStatus.NOT_FOUND,
            message: error.message
        });
    }
};

export const getBlogByUserId = async (req, res) => {
    try {
        const blogs = await Blog.find();
    } catch (error) {

    }
};

export const getBlogs = async (req, res) => {

    try {
        const page = req.query.page * 1 || 1;
        const limit = req.query.limit * 1;

        const data = await Blog.find({}).sort({ _id: -1 })
            .skip(page * limit).limit(limit)
            .populate({ path: 'author', select: '-password' })
            .populate({
                path: 'comments', populate: {
                    path: 'created_by', select: '-password'
                }
            });
        return res.status(200).json({
            status: httpStatus.OK,
            message: 'Success',
            length: data.length,
            page: page,
            limit: limit,
            data: data
        });
    } catch (error) {
        console.log(error.message);
        return res.status(400).json({
            status: httpStatus.BAD_REQUEST,
            message: error.message
        });
    }
};


export const updateBlog = async (req, res) => {
    try {
        const blog = await Blog.findByIdAndUpdate({ _id: req.params.id },
            {
                $set: {
                    content: req.body.content,
                    mediaType: req.body.mediaType,
                    mediaUrl: req.body.mediaUrl,
                    hashtags: req.body.hashtags
                }
            },
            { new: true }
        );
        if (!blog) {
            return res.status(404).json({
                status: httpStatus.NOT_FOUND,
                message: 'Blog not found'
            });
        }
        return res.status(200).json({
            status: httpStatus.OK,
            message: 'Blog successfully updated',
        });

    } catch (error) {
        console.log(error.message);
        return res.status(400).json({
            status: httpStatus.BAD_REQUEST,
            message: error.message,
            data: null
        });
    }
};


export const deleteBlog = async (req, res) => {
    const id = req.params.id;
    if (!mongoose.Types.ObjectId.isValid(id)) {
        return res.status(400).json({
            status: httpStatus.BAD_REQUEST,
            message: "Invalid blog id",
        });
    }
    try {
        const blog = await Blog.findOne({ _id: id });
        if (!blog) {
            return res.status(400).json({
                status: httpStatus.BAD_REQUEST,
                message: 'No blog found',
            });
        }
        await Blog.findByIdAndDelete(req.params.id);
        return res.status(200).json({
            status: httpStatus.OK,
            message: 'Blog successfully deleted'
        });

    } catch (error) {
        console.log(error.message);
        return res.status(400).json({
            status: httpStatus.BAD_REQUEST,
            message: error.message
        });
    }
};


export const likeAndUnlikeBlog = async (req, res) => {
    try {
        const blog = await Blog.findById(req.body.id);
        if (blog.likes.includes(req.params.id)) {
            await Blog.findByIdAndUpdate(req.body.id,
                {
                    $pull: { likes: req.params.id }
                }, { new: true }).exec();

            return res.status(200).json({
                status: httpStatus.OK,
            });
        } else {
            await Blog.findByIdAndUpdate(req.body.id,
                {
                    $push: { likes: req.params.id }
                }, { new: true }).exec();
            return res.status(200).json({
                status: httpStatus.OK,
            });
        }
    } catch (error) {
        return res.status(400).json({
            status: httpStatus.BAD_REQUEST,
            message: error.message
        });
    }
};
