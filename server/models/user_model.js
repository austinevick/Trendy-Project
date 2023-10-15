import mongoose from "mongoose";
import bcrypt from 'bcrypt';


const userSchema = new mongoose.Schema({
    first_name: {
        type: String,
        required: true
    },
    last_name: {
        type: String,
        required: true
    },
    email: {
        type: String,
        required: 'email is required',
        unique: true,
        trim: true,
    },
    about: { type: String },
    profession: {
        type: String,
        required: true
    },
    imageUrl: { type: String, default: 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b5/Windows_10_Default_Profile_Picture.svg/2048px-Windows_10_Default_Profile_Picture.svg.png' },
    following: [{ type: mongoose.Schema.ObjectId, ref: 'User' }],
    followers: [{ type: mongoose.Schema.ObjectId, ref: 'User' }],
    saved_post: [{ type: mongoose.Schema.ObjectId, ref: 'Blog' }],
    posts: [{ type: mongoose.Schema.ObjectId, ref: 'Blog' }],
    password: {
        type: String,
        required: 'password is required'
    }
}, {
    timestamps: true
});

userSchema.pre('save', async function (next) {
    if (!this.isModified('password')) {
        next();
    }
    const salt = await bcrypt.genSalt(10);
    this.password = await bcrypt.hash(this.password, salt);
});

userSchema.methods.matchPassword = async function (enterPassword) {
    return await bcrypt.compare(enterPassword, this.password);
};

const User = mongoose.model('User', userSchema);

export default User;