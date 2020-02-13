const mongoose = require('mongoose');

let taskSchema = mongoose.Schema({
    title: {type: String, unique: true, required: true},
    description: {type: String, required: true},
    completeBy: {type: Date, required: true},
    assignee: {type: String, required: true},
    responsible: {type: String, defaultValue: ""},
    status: {type: String, enum: ['Pending', 'In Progress', 'Completed'], defaultValue: 'Pending'}
}, {timeStamps: true});

module.exports = mongoose.model('task', taskSchema);