import dbConnect from '../config/db-config.js';

// READ ALL
const getAll = () => {
    return new Promise((resolve, reject) => {
        dbConnect.query('SELECT * FROM video_game', (err, results) => {
            if (err) reject(err);
            else resolve(results);
        })
    })
}

// READ ONE
const getOneById = (id) => {
    return new Promise((resolve, reject) => {
        dbConnect.query('SELECT * FROM video_game WHERE id = ?', id, (err, result) => {
            if (err) reject(err);
            else resolve(result[0]);
        })
    })
}

// DELETE
const deleteById = (id) => {
    return new Promise((resolve, reject) => {
        dbConnect.query('DELETE FROM video_game WHERE id = ?', id, (err, result) => {
            if (err) reject(err);
            else resolve(result.affectedRows);
        })
    })
}

// CREATE
const createNew = (video_game) => {
    const { title } = video_game;
    return new Promise((resolve, reject) => {
        dbConnect.query('INSERT INTO video_game (`id`, `name`, `image`, `description`, `id_rate`) VALUES (?)', title, (err, result) => {
            if (err) reject(err);
            else resolve(result.insertId);
        })
    })
}

// UPDATE
const updateVideoGame = (video_game) => {
    const { title, id } = video_game;
    return new Promise((resolve, reject) => {
        dbConnect.query('UPDATE video_game SET title = ? WHERE id = ?', [title, id], (err, result) => {
            if (err) reject(err);
            else resolve(result);
        })
    })
}

export default { getAll, getOneById, deleteById, createNew, updateVideoGame };
