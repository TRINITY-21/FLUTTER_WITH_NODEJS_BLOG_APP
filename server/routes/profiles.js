const Profile = require('../models/Profile');
const { auth } = require("../middleware/auth");
const express = require('express');
const router = express.Router();
const multer = require('multer');
const path = require('path');


const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, 'uploads/');
    },
    filename: function (req, file, cb) {
        cb(null, req.user.username + path.extname(file.originalname));
    },
    fileFilter: function (req, file, cb) {
        let ext = path.extname(file.originalname);
        if (ext !== '.jpg'|| '.png' || '.jpeg')
            cb(res.json({ Error: 'Only images' }, false));

    }
});

const upload = multer({
    storage: storage,
    limits: {
        fileSize:1024*1024*6,
    }
}).single('file');

router.patch('/upload', auth, (req, res) => {
    upload(req, res, ((err)  => {
        Profile.findOneAndUpdate({ username: req.user.username },
            { $set: { img: res.req.file.path } }, { new: true }).then((profile, err) => {
                if (err) res.json({ success: false, err });
                res.status(200).json({ success: true, profile:profile });
            });

            if (err) res.json({ success: false, err });

       
    }));
    
});



// router.post('/upload',(req, res) => {
//     upload(req, res, (err => {
//         if (err) res.json({ success: false, err });
//         res.status(200).json({ success: true, filePath: req.file.path });
//     }));
    
// });


/// add profile
router.post('/add', auth, (req, res) => {
    const profile = Profile({
        username: req.user.username,
        name: req.body.name,
        DOB:req.body.DOB,
        profession: req.body.profession,
        titleline: req.body.titleline,
        about: req.body.about,
        
            
    });

    profile.save().then(() => {
        
        return res.status(200).json({ success: true, msg: "Profile saved Successfully", profile });
    }).catch((err) => {
        if (err) return res.json({ success: false, err });
    })

});


router.get('/checkProfile', auth, (req, res) => {
    Profile.findOne({ username: req.user.username },(err, profile) => {
        if (err) return res.status(400).json({ success: false, err });
        else if (profile == null) {
            return res.json({ success: false });
        } else {
        
        return res.status(200).json({ success: true });

        }
        
    })
});


router.get('/getData', auth, (req, res) => {
    Profile.findOne({ username: req.user.username }, (err, result) => {
        if (err) return res.status(400).json({ success: false, err });
        else if (result == null) {
            return res.json({ success: false, data: [] });
        } else {
        
            return res.status(200).json({ success: true, data: result });

        }
        
    });
});


router.patch('/update', auth, (req, res) => {
    Profile.findOneAndUpdate({ username: req.user.username }, (req.body), (err, result) => {
        if (err) return res.status(400).json({ success: false, err });
        return res.status(200).json({ success: true, data: result });
        
    });
});

module.exports = router;