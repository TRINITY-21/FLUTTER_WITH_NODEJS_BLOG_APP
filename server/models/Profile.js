const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const profileSchema = Schema({
    username: {
        type: String,
        required:true,
        unique:true

    },
    name:String,
    profession:String,
    DOB: String,
    titleline: String,
    about:String,
    img:{
        type:String,
        default:""
    }
   
},
 { timestamps: true });

    
const Profile = mongoose.model('Profile', profileSchema);

module.exports = Profile;
