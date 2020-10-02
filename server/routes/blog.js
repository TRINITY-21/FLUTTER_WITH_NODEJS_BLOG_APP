const Blog = require('../models/Blog');
const { auth } = require("../middleware/auth");
const express = require('express');
const router = express.Router();

/// add profile
router.post('/add', auth, (req, res) => {
    const blog = Blog({
        username: req.user.username,
        body: req.body.body,
        title: req.body.title,
        
            
    });

    blog.save().then(() => {
        
        return res.status(200).json({ success: true, msg: "blog saved Successfully", blog });
    }).catch((err) => {
        if (err) return res.json({ success: false, err });
    })

});




module.exports = router;