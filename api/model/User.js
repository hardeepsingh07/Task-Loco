const mongoose = require('mongoose');
const bcrypt = require('bcrypt-nodejs');

let userSchema = mongoose.Schema({
    username: {type: String, unique: true, required: true},
    firstName: {type: String, required: true},
    email: {type: Boolean, defaultValue: false},
    password: {type: String, required: true},
    apiKey: {type: String}
}, {timeStamps: true});

userSchema.pre('save', function(next) {
    let user = this;
    if (!user.isModified(this.password)) return next();
    bcrypt.genSalt(8, function(err, salt) {
        if (err) return next(err);
        bcrypt.hash(user.password, salt, function(err, hash) {
            if (err) return next(err);
            user.password = hash;
            next();
        });
    });
});

userSchema.methods.validatePassword = function(candidatePassword, cb) {
    bcrypt.compare(candidatePassword, this.password, function(err, isMatch) {
        if (err) return cb(err);
        cb(null, isMatch);
    });
};

module.exports = mongoose.model('user', userSchema);