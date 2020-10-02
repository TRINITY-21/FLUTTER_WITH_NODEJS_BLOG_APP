const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const blogSchema = Schema({
    username: {
        type: String,
    },

    title: String,
    body: String,
    coverImage: {
        default: "", 
    },
    like: Number,
    share: Number,
    commnet:Number,  
},
 { timestamps: true });

    
const Blog = mongoose.model('Blog', blogSchema);

module.exports = Blog;
