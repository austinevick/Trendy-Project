import express from 'express';
import { followAndUnfollow, getUserById, getUserPosts, getUsers, login, register, updatePassword, updateProfilePicture, updateUserProfile } from '../controllers/user_controller.js';
import { protect } from '../utils/middleware.js';
import { createBlog, deleteBlog, getBlogById, getBlogs, likeAndUnlikeBlog, updateBlog } from '../controllers/blog_controller.js';
import { createComment, deleteComment, getCommentByBlogId, getCommentById, likesAndUnlikeComment } from '../controllers/comment_controller.js';
import { getRepliesByCommentId, replyToComment } from '../controllers/reply_controller.js';


const router = express.Router();

// User routes
router.post('/user/register', register);
router.post('/user/login', login);
router.get('/user/all', protect, getUsers);
router.put('/user/:id', protect, updateUserProfile);
router.put('/user/:id/picture', protect, updateProfilePicture);
router.put('/user/follow/:id', protect, followAndUnfollow);
router.put('/user/password/:id', protect, updatePassword);
router.get('/user/:id', protect, getUserById);
router.get('/user/posts/:id', protect, getUserPosts);

// Blog routes
router.post('/blog', protect, createBlog);
router.get('/blog', protect, getBlogs);
router.get('/blog/:id', protect, getBlogById);
router.put('/blog/:id', protect, updateBlog);
router.put('/blog/likes/:id', protect, likeAndUnlikeBlog);
router.delete('/blog/:id', protect, deleteBlog);

// Comment routes
router.post('/comment', protect, createComment);
router.get('/comment/blog/:id', protect, getCommentByBlogId);
router.get('/comment/:id', protect, getCommentById);
router.put('/comment/likes/:id', protect, likesAndUnlikeComment);
router.delete('/comment/:id', protect, deleteComment);

// Reply routes
router.post('/reply', protect, replyToComment);
router.get('/reply/comment/:id', protect, getRepliesByCommentId);

export default router;