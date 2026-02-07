const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');

// User Schema (Qaabka Macluumaadka Isticmaalaha)
const userSchema = mongoose.Schema({
    name: {
        type: String,
        required: true,
    },
    email: {
        type: String,
        required: true,
        unique: true,
    },
    password: {
        type: String,
        required: true,
    },
    role: {
        type: String,
        default: 'student', // 'student' or 'admin'
    },
}, {
    timestamps: true,
});

// Password Matching Method (Habka Isbarbar-dhiga Password-ka)
userSchema.methods.matchPassword = async function (enteredPassword) {
    return await bcrypt.compare(enteredPassword, this.password);
};

// Hashing Password Before Saving (Qaybta Kobcinta Amniga Password-ka)
userSchema.pre('save', async function (next) {
    if (!this.isModified('password')) {
        next();
    }
    const salt = await bcrypt.genSalt(10);
    this.password = await bcrypt.hash(this.password, salt);
});

const User = mongoose.model('User', userSchema);

module.exports = User;
