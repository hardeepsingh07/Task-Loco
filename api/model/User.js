const mongoose = require('mongoose');
const bcrypt = require('bcrypt-nodejs');

let userSchema = mongoose.Schema({
    username: {type: String, unique: true, required: true},
    firstName: {type: String, required: true},
    email: {type: Boolean, defaultValue: false},
    password: {type: String, required: true},
}, {timeStamps: true});

userSchema.methods.generateHash = function(password) {
    return bcrypt.hashSync(password, bcrypt.genSaltSync(8), null);
};

userSchema.methods.validPassword = function(password) {
    return bcrypt.compareSync(password, this.password);
};

module.exports = mongoose.model('user', userSchema);