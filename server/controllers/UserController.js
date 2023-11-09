import User from '../models/UserModel.js';
import httpStatus from 'http-status';
import generateToken from '../utils/generate_token.js';
import bcrypt from 'bcrypt';
import Post from '../models/PostModel.js';


export const getUserById = async (req, res) => {
    try {
        const user = await User.findById({ _id: req.params.id })
            .select('-password')
            .populate('posts')
            .populate('followers', ['-password'])
            .exec();
        if (!user) {
            return res.status(404).json({
                status: 404,
                message: 'User not found'
            });
        }
        return res.status(200).json({
            status: 200,
            message: 'Success',
            data: user
        });
    } catch (error) {
        return res.status(400).json({
            status: 400,
            message: error.message
        });
    }
};

export const getUsers = async (req, res) => {
    try {
        const users = await User.find({})
            .select('-password')

            .exec();
        return res.status(200).json({
            status: 200,
            message: 'Success',
            data: users
        });
    } catch (error) {
        return res.status(400).json({
            status: 400,
            message: error.message
        });
    }
};
export const getUserPosts = async (req, res) => {
    try {
        const posts = await Post.where('author').equals(req.params.id)
            .select('content mediaType mediaUrl')
            .exec();
        return res.status(200).json({
            status: 200,
            message: 'Success',
            data: posts
        });
    } catch (error) {
        return res.status(400).json({
            status: 400,
            message: error.message
        });
    }
};

export const login = async (req, res) => {
    const { email, password } = req.body;
    try {
        console.log(req.body);
        const user = await User.findOne({ email });
        if (user && (await user.matchPassword(password))) {
            let token = generateToken(user._id);
            const data = await User.findOne({ email }).select('-password');
            return res.status(httpStatus.OK).json({
                status: httpStatus.OK,
                message: 'success',
                data: data,
                token: token
            });
        }
        return res.status(httpStatus.BAD_REQUEST).json({
            status: httpStatus.BAD_REQUEST,
            message: 'Invalid email or password'
        });
    } catch (error) {
        console.log(error.message);
        return res.status(400).json({
            status: 400,
            message: error.message

        });

    }
};

export const register = async (req, res) => {
    try {
        const userExists = await User.findOne({ email: req.body.email });
        if (userExists) {
            return res.status(400).json({
                status: httpStatus.BAD_REQUEST,
                message: 'User already exists',
            });
        }
        const user = new User(req.body);
        const newUser = await user.save();
        if (newUser) {
            const data = await User.findOne({ email: newUser.email }).select('-password');
            let token = generateToken(newUser._id);
            return res.status(201).json({
                status: httpStatus.CREATED,
                message: 'success',
                data: data,
                token: token
            });
        }
    } catch (error) {
        console.log(error.message);
        return res.status(httpStatus.BAD_REQUEST).json({
            status: httpStatus.BAD_REQUEST,
            message: error.message,
        });
    }
};

export const updateUserProfile = async (req, res) => {
    try {
        const user = await User.findByIdAndUpdate({ _id: req.params.id },
            {
                first_name: req.body.first_name,
                last_name: req.body.last_name,
                email: req.body.email,
                about: req.body.about,
                profession: req.body.profession,
                imageUrl: req.body.imageUrl,
            },
            { new: true }
        );
        console.log(req.body);
        if (!user) {
            return res.status(404).json({
                status: httpStatus.NOT_FOUND,
                message: 'There is no user with these id'
            });
        } else {
            return res.status(200).json({
                status: httpStatus.OK,
                message: 'Profile successfully updated',
            });
        }
    } catch (error) {
        console.log(error.message);
        return res.status(httpStatus.BAD_REQUEST).json({
            status: httpStatus.BAD_REQUEST,
            message: error.message
        });
    }
};

export const updatePassword = async (req, res) => {
    try {
        const { oldPassword, newPassword } = req.body.password;
        const user = await User.findById(req.params.id);

        if (bcrypt.compareSync(oldPassword, user.password)) {
            const salt = await bcrypt.genSalt(10);
            let hasedPassword = bcrypt.hashSync(newPassword, salt);
            await User.findByIdAndUpdate({ _id: req.params.id },
                { password: hasedPassword });
            return res.status(200).json({
                status: httpStatus.OK,
                message: 'Password successfully updated',
            });
        }
        res.status(400).json({
            status: 400,
            message: "Your old password is incorrect."
        });

    } catch (error) {
        console.log(error.message);
        return res.status(httpStatus.BAD_REQUEST).json({
            status: httpStatus.BAD_REQUEST,
            message: error.message
        });
    }
};

export const updateProfilePicture = async (req, res) => {
    try {
        await User.findByIdAndUpdate({ _id: req.params.id },
            { imageUrl: req.body.imageUrl });
        return res.status(200).json({
            status: httpStatus.OK,
            message: 'Profile successfully updated',
        });

    } catch (error) {
        console.log(error.message);
        return res.status(httpStatus.BAD_REQUEST).json({
            status: httpStatus.BAD_REQUEST,
            message: error.message
        });
    }
};

export const followAndUnfollow = async (req, res) => {
    try {
        const user = await User.findById(req.params.id);
        const currentUser = await User.findById(req.body.userId);
        if (!user.followers.includes(req.body.userId)) {
            await user.updateOne({ $push: { followers: req.body.userId } });
            await currentUser.updateOne({ $push: { following: req.body.userId } });
            res.status(200).json({ status: 200, message: 'User has been followed' });
        } else {
            await user.updateOne({ $pull: { followers: req.body.userId } });
            await currentUser.updateOne({ $pull: { following: req.body.userId } });
            res.status(200).json({ status: 200, message: 'User has been unfollowed' });
        }
    } catch (error) {
        return res.status(httpStatus.BAD_REQUEST).json({
            status: httpStatus.BAD_REQUEST,
            message: error.message
        });
    }
};
