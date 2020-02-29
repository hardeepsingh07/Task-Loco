const mongoose = require('mongoose');
const bcrypt = require('bcrypt');

let userSchema = mongoose.Schema({
    username: {type: String, unique: true, required: true},
    name: {type: String, required: true},
    email: {type: String, required: true},
    password: {type: String, required: true},
    apiKey: {type: String}
}, {timestamps: true});

userSchema.pre('save', function(next) {
    let user = this;
    if (!user.isModified('password')) return next();
    bcrypt.genSalt(8, function(err, salt) {
        if (err) return next(err);
        bcrypt.hash(user.password, salt, function(err, hash) {
            if (err) return next(err);
            user.password = hash;
            next();
        });
    });
});

userSchema.methods.validatePassword = function(checkPassword, cb) {
    bcrypt.compare(checkPassword, this.password, function(err, isMatch) {
        if (err) return cb(err);
        cb(null, isMatch);
    });
};

module.exports = mongoose.model('user', userSchema);