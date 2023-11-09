import express from 'express';
import { followAndUnfollow, getUserById, getUserPosts, getUsers, login, register, updatePassword, updateProfilePicture, updateUserProfile } from '../controllers/UserController.js';
import { protect } from '../utils/middleware.js';
import { createPost, deletePost, getPostById, getPosts, likeAndUnlikePost, updatePost } from '../controllers/PostController.js';
import { createComment, deleteComment, getCommentByBlogId, getCommentById, likesAndUnlikeComment } from '../controllers/CommentController.js';
import { getRepliesByCommentId, replyToComment } from '../controllers/ReplyController.js';


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

// Post routes
router.post('/post', protect, createPost);
router.get('/post', protect, getPosts);
router.get('/post/:id', protect, getPostById);
router.put('/post/:id', protect, updatePost);
router.put('/post/likes/:id', protect, likeAndUnlikePost);
router.delete('/post/:id', protect, deletePost);

// Comment routes
router.post('/comment', protect, createComment);
router.get('/comment/post/:id', protect, getCommentByBlogId);
router.get('/comment/:id', protect, getCommentById);
router.put('/comment/likes/:id', protect, likesAndUnlikeComment);
router.delete('/comment/:id', protect, deleteComment);

// Reply routes
router.post('/reply', protect, replyToComment);
router.get('/reply/comment/:id', protect, getRepliesByCommentId);


export default router;