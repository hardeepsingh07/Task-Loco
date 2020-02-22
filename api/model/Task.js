const mongoose = require('mongoose');

let taskSchema = mongoose.Schema({
    title: {type: String, unique: true, required: true},
    description: {type: String, required: true},
    completeBy: {type: Date, required: true},
    assignee: {type: String, required: true},
    responsible: {type: String, default: ""},
    priority: {type: String, enum: ['Standard', 'High'], default: 'Standard'},
    status: {type: String, enum: ['Pending', 'In Progress', 'Completed'], default: 'Pending'}
}, {timeStamps: true});

module.exports = mongoose.model('task', taskSchema);