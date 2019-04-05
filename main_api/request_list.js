const expess = require('express');
const router = expess.Router();

router.get('/', (req, res) => {
    res.send("API LIST");
});

router.get('/search',(req,res) => {
    res.send('Search');
})



module.exports = router;