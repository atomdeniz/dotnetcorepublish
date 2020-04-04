const crypto = require('crypto')
const express = require('express')
const bodyParser = require('body-parser')
const shellExec = require('shell-exec')
const dotenv = require('dotenv');
dotenv.config();

const secret = process.env.SECRET;
const sigHeaderName = 'X-Hub-Signature'
const sigHeaderEventName = 'X-GitHub-Event'

const app = express()
app.use(bodyParser.json())

function verifyPostData(req, res, next) {
    const payload = JSON.stringify(req.body)
    if (!payload) {
        return next('Request body empty')
    }
    const sig = req.get(sigHeaderName) || ''
    const hmac = crypto.createHmac('sha1', secret)
    const digest = Buffer.from('sha1=' + hmac.update(payload).digest('hex'), 'utf8')
    const checksum = Buffer.from(sig, 'utf8')
    if (checksum.length !== digest.length || !crypto.timingSafeEqual(digest, checksum)) {
        return next(`Request body digest (${digest}) did not match ${sigHeaderName} (${checksum})`)
    }
    return next()
}

app.post('/webhook', verifyPostData, function (req, res) {
    const event = req.get(sigHeaderEventName) || ''
    if (event == 'push') {  
        shellExec('cp ../Dockerfile ./Dockerfile').then(
            shellExec('cp ../docker-compose.yml ./docker-compose.yml').then(
                shellExec('sh publish.sh').then().catch(console.log)
            ).catch(console.log)
        ).catch(console.log)
        // shell.exec('../publish.sh')
    } else {
        res.status(200).send('Request body was signed')
    }
})

app.use((err, req, res, next) => {
    if (err) console.error(err)
    res.status(403).send('Request body was not signed or verification failed')
})

app.listen(9000)
