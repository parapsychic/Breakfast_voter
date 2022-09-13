
var express = require("express");
const cors = require("cors");

var app = express();
const axios = require("axios");

app.use(cors());

const headers = {
  'api-key': '<APIKEY>',
  'Content-Type': 'application/json',
}

function randomNum(min, max) {  
  return Math.floor(
    Math.random() * (max - min) + min
  )
}


app.get("/otp/:phone", function (req, res) {

    const phone = req.params.phone;

    const OTP = randomNum(100000, 999999 );

    // amazing encryption 🤣
    const encryptedmsg = OTP + 2000;

      const data = {
        body: `Hi user, Please find the below OTP ${OTP} -Kaleyra`, sender: `KALERA`, to:`+91${phone}`, type:`OTP`, template_id:`1107165959873165373`,
        
      }
    axios.post('https://api.kaleyra.io/v1/<SID>/messages', data, {
      headers: headers
    })
    .then((response) => {
      console.log() 
    })
    .catch((error) => {
      console.log(error)
    })
    
    res.send(`${encryptedmsg}`);
});



var server = app.listen(8000, function () {
  var host = server.address().address;
  var port = server.address().port;

  console.log("Server app listening at http://%s:%s", host, port);
});
