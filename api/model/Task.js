const mongoose = require('mongoose');

let taskSchema = mongoose.Schema({
    title: {type: String, required: true},
    description: {type: String, required: true},
    completeBy: {type: String, required: true},
    assignee: { username: {type: String, default: ""}, name: {type: String, default: ""} },
    responsible: { username: {type: String, default: ""}, name: {type: String, default: ""} },
    priority: {type: String, enum: ['Standard', 'High'], default: 'Standard'},
    status: {type: String, enum: ['Pending', 'In Progress', 'Completed', 'Closed'], default: 'Pending'},
}, {timestamps: true});

module.exports = mongoose.model('task', taskSchema);