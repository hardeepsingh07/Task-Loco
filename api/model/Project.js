const mongoose = require('mongoose');

let projectSchema = mongoose.Schema({
    name: {type: String, required: true},
    projectId: {type: String, required: true, unique: true},
    description: {type: String, required: true},
    users: [{username: {type: String, required: true}, name: {type: String, required: true}}],
    starred: {type: Boolean, default: false},
    autoClose: {type: Boolean, default: false}
}, {timestamps: true});

module.exports = mongoose.model('project', projectSchema);