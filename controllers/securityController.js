import express from 'express';
import Joi from 'joi';
import User from '../models/userModel.js';
import bcrypt from 'bcrypt';
import jwt from 'jsonwebtoken';

const router = express.Router();
const saltRounds = 10;

const schemaUser = Joi.object({
    email: Joi.string().email().required().trim(true),
    password: Joi.string().regex(/^[a-zA-Z0-9]{3,30}$/).required().trim(true),
    is_admin: Joi.boolean().default(false)
});

router.post('/register', async (req, res) => {
    const { email, password } = req.body;
    try {
        const userIsValid = schemaUser.validate({ email, password });
        const userExist = await User.findByEmail(userIsValid.value.email);
        if (userIsValid.error) return res.status(422).json({ error: userIsValid.error.details[0].message });
        if (userExist) return res.json({ error: 'Email already exists' }).status(409);
        try {
            const hash = bcrypt.hashSync(userIsValid.value.password, saltRounds);
            userIsValid.value.password = hash;
            const userId = await User.createNew(userIsValid.value);
            const user = await User.findById(userId);
            res.status(201).json(user)
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

router.post('/login', async (req, res) => {
    const { email, password } = req.body;
    try {
        const userIsValid = schemaUser.validate({ email, password });
        if (userIsValid.error) return res.status(422).json({ error: userIsValid.error.details[0].message });
        const userExist = await User.findByEmail(userIsValid.value.email);
        if (userExist) {
            const passwordIsValid = bcrypt.compareSync(userIsValid.value.password, userExist.password);
            if (passwordIsValid) {
                const token = jwt.sign({ id: userExist.id, role: userExist.is_admin }, process.env.SERVER_SECRET, { expiresIn: 360000 * 2 });
                res.send({ token: token, user: { email: userExist.email, role: userExist.is_admin } }).status(200);
            }
            else res.json({ error: 'Invalid password' }).status(401);
        } else res.json({ error: 'User not found' }).status(404);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

// middleware to check if token client is valid
const verifyJWT = (req, res, next) => {
    const token = req.headers["x-access-token"];
    if (!token) return res.json({ error: "No token provided" }).status(401);
    jwt.verify(token, process.env.SERVER_SECRET, (err, decoded) => {
        if (err) return res.json({ error : "Invalid Token"}).status(401);
        next();
    })
}

router.get('/user-is-auth', verifyJWT, (req, res) => {
    res.json({ auth: true, message: 'User is auth' }).status(200);
})

export default router;