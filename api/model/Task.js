const mongoose = require('mongoose');

let taskSchema = mongoose.Schema({
    title: {type: String, unique: true, required: true},
    description: {type: String, required: true},
    completeBy: {type: String, required: true},
    assignee: { username: {type: String, default: ""}, name: {type: String, default: ""} },
    responsible: { username: {type: String, default: ""}, name: {type: String, default: ""} },
    priority: {type: String, enum: ['Standard', 'High'], default: 'Standard'},
    status: {type: String, enum: ['Pending', 'In Progress', 'Completed'], default: 'Pending'},
    closed: {type: Boolean, default: false}
}, {timestamps: true});

module.exports = mongoose.model('task', taskSchema);