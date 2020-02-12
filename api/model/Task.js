const mongoose = require('mongoose');

let taskSchema = mongoose.Schema({
    title: {type: String, unique: true, required: true},
    description: {type: String, required: true},
    completed: {type: Boolean, defaultValue: false},
    completeBy: Date,
    assignee: String,
    responsible: String,
    status: {type: String, enum: ['Pending', 'In Progress', 'Completed']}
}, {timeStamps: true});

module.exports = mongoose.model('task', taskSchema);